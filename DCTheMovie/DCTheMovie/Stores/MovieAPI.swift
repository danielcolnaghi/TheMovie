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

class MovieAPI {
    
    private static let apiURL = "https://api.themoviedb.org"
    private static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    private static let apiImageURL = "https://image.tmdb.org/t/p/w"
	private static let defaultProperties = "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false"
    
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
    
    func moviesFromPage(_ page: Int, success: @escaping ([Movie]) -> Void, error: @escaping (String) -> Void) {

        let url = "\(MovieAPI.apiURL)/3/discover/movie?api_key=\(MovieAPI.apiKey)\(MovieAPI.defaultProperties)&page=\(page)"

        Alamofire.request(url).responseJSON { (response) in

            guard let result = response.result.value else {
                error("Error getting results from server.")
                return
            }
            
            if let movies = self.parseMovies(result) {
                success(movies)
            } else {
                error("Error getting results from JSON response.")
            }
        }
    }
	
    func moviesSearch(To query: String, page: Int, success: @escaping ([Movie]) -> Void, error: @escaping (String) -> Void) {
        
        let url = "\(MovieAPI.apiURL)/3/search/movie?api_key=\(MovieAPI.apiKey)\(MovieAPI.defaultProperties)&query=\(query)&page=\(page)"
        
        Alamofire.request(url).responseJSON { (response) in
            
            guard let result = response.result.value else {
                error("Error getting results from server.")
                return
            }

            if let movies = self.parseMovies(result) {
                success(movies)
            } else {
                error("Error getting results from JSON response.")
            }
            
        }
    }
    
    func parseMovies(_ result: Any) -> [Movie]? {
        let json = JSON(result)

        if let error = json.error {
            print("\(error.localizedDescription)")
            return nil
        }
        
        var movies = [Movie]()
        
        if let resData = json["results"].arrayObject {
            for obj in resData as! [[String:AnyObject]] {
                let m = Movie(dic: obj)
                movies.insert(m, at: 0)
            }
        }
        
        return movies
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
