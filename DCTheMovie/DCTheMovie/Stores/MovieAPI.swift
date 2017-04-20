//
//  MovieAPI.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 20/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation
import Alamofire

class MovieAPI {
    
    private static let apiURL = "https://api.themoviedb.org"
    private static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    
    func moviesFromPage(_ page: Int, success: ([Movie]) -> Void, error: (String) -> Void) {

        let url = "\(MovieAPI.apiURL)3/discover/movie?api_key=\(MovieAPI.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)"
        
        
        Alamofire.request(url).responseJSON { (response) in

            print(response)
//            response.response?.statusCode
            
//            if let r = response as Array {
//            
//            }
//                
//            return response
        }
        
        
    }
    
    func hardProcessingWithString(input: String, completion: (_ result: String) -> Void) {
     
            completion("we finished!")
    }
    
}
