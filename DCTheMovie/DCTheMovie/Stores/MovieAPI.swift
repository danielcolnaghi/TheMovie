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

class MovieAPI {
    
    private static let apiURL = "https://api.themoviedb.org"
    private static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    private static let apiImageURL = "https://image.tmdb.org/t/p/w300"
	private static let defaultProperties = "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false"
    
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
    
	func downloadImage(_ imagePath: String, success: @escaping (UIImage) -> Void) -> Void {
	
		let url = "\(MovieAPI.apiImageURL)\(imagePath)"
		Alamofire.request(url).responseImage { (response) in
			if let image = response.result.value {
				success(image)
			}
		}

	}
}
