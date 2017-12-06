//
//  MovieAPI.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 20/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
#if DEBUG
import OHHTTPStubs
#endif

struct MovieParams {
    var page: Int
    var query: String
    var type: String
}

class MovieAPI {
    
    private static let apiURL = "https://api.themoviedb.org/3/"
    private static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    private static let apiImageURL = "https://image.tmdb.org/t/p/w"
	private static let defaultProperties = "&language=en-US&include_adult=false&include_video=false" //&sort_by=popularity.desc
    
    init() {
        
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("STUBS") {
            stub(condition: pathEndsWith("/movie")) { request in
                return OHHTTPStubsResponse(
                    fileAtPath: OHPathForFile("movies.json", type(of: self))!,
                    statusCode: 200,
                    headers: ["Content-Type":"application/json"]
                )
            }
        }
        #endif
    }
    
    deinit {
        #if DEBUG
        OHHTTPStubs.removeAllStubs()
        #endif
    }
    
    func movieDetailsWithId(_ movieId: Int, success: @escaping (_ movie: Movie) -> Void, error: @escaping (String) -> Void) {
        
        let url = "\(MovieAPI.apiURL)movie/\(movieId)?api_key=\(MovieAPI.apiKey)\(MovieAPI.defaultProperties)"
        
        Alamofire.request(url).responseJSON { (response) in
            
            guard let result = response.result.value else {
                error("Error getting results from server.")
                return
            }
            
            if let values = self.parseMovies(result) {
                
                if values.movies.count > 0 {
                    success(values.movies[0])
                } else {
                    error("Out of range.")
                }
                
            } else {
                error("Error getting results from JSON response.")
            }
            
        }
    }
    
    func moviesWithParams(_ params: MovieParams, success: @escaping (_ movies: [Movie],_ pages: Int) -> Void, error: @escaping (String) -> Void) {
        
        let q = params.query.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "\(MovieAPI.apiURL)\(params.type)/movie?api_key=\(MovieAPI.apiKey)\(MovieAPI.defaultProperties)&query=\(q)&page=\(params.page)"
        
        Alamofire.request(url).responseJSON { (response) in
            
            guard let result = response.result.value else {
                error("Error getting results from server.")
                return
            }
            
            if let values = self.parseMovies(result) {
                success(values.movies, values.pages)
            } else {
                error("Error getting results from JSON response.")
            }
            
        }
    }
    
    func parseMovies(_ result: Any) -> (movies: [Movie], pages: Int)? {
        let json = JSON(result)

        if let error = json.error {
            print("\(error.localizedDescription)")
            return nil
        }
        
        var movies = [Movie]()
        var pages = 0
        
        if let resData = json["results"].arrayObject {
            for obj in resData as! [[String:AnyObject]] {
                let m = Movie(dic: obj)
                movies.insert(m, at: 0)
            }
            pages = json["total_pages"].intValue
            
        } else if let singleMovie = json.dictionaryObject {
            let m = Movie(dic: singleMovie)
            movies.insert(m, at: 0)
        }
        
        return (movies, pages)
    }
    
    func downloadImage(_ imagePath: String, withSize size: Int, success: @escaping (UIImage) -> Void, error: @escaping (String) -> Void) -> Void {
	
		let url = "\(MovieAPI.apiImageURL)\(size)\(imagePath)"
		Alamofire.request(url).responseImage { (response) in
            
            if let e = response.result.error {
                error(e.localizedDescription)
            } else {
                if let image = response.result.value {
                    success(image)
                } else {
                    error("Loading Image Error - Result value nil")
                }
            }
		}

	}
}
