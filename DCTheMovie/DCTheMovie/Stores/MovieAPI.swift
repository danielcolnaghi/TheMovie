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

struct MovieAPI {
    
    private static let apiURL = "https://api.themoviedb.org"
    private static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    private static let apiImageURL = "https://image.tmdb.org/t/p/w300"
	
    func moviesFromPage(_ page: Int, success: @escaping ([Movie]) -> Void, error: @escaping (String) -> Void) {

        let url = "\(MovieAPI.apiURL)/3/discover/movie?api_key=\(MovieAPI.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)"

        Alamofire.request(url).responseJSON { (response) in

			let json = JSON(response.result.value!)
			var movies = [Movie]()
			
			if let resData = json["results"].arrayObject {
				for obj in resData as! [[String:AnyObject]] {
				
					let m = Movie(dic: obj)
					movies.insert(m, at: 0)
				}
				
				success(movies)
			} else {
				error("Error getting results from JSON response.")
			}
        }
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
