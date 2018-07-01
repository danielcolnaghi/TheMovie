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

#if DEBUG
import OHHTTPStubs
#endif

struct MovieParams {
    
    enum MovieType {
        case discover
        case search
    }
    
    var page: Int
    var query: String
    var type: MovieType
}

class MovieAPI {
    
    static let shared = MovieAPI()
    
    private init() {
        
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
    
    func movieDetailsWithId(_ movieId: Int, success: @escaping (_ movie: Movie) -> Void, errorMessage: @escaping (String) -> Void) {
        
        guard let url = try? APIRouter.movie(id: movieId).asURLRequest() else { return }
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.error {
                errorMessage("Error getting response from server. \(error.localizedDescription)")
                return
            }
            
            if let data = response.data {
            
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(Movie.self, from: data)
                    
                    success(movie)
                } catch {
                    errorMessage("JSON decoder fail with data: \(String(data: data, encoding: .utf8) ?? "")")
                }
            }
        }
    }
    
    func moviesWithParams(_ params: MovieParams, success: @escaping (_ movies: [Movie],_ pages: Int) -> Void, errorMessage: @escaping (String) -> Void) {
        
        var url: URLRequest?
        
        if params.type == .search {
            let q = params.query.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            url = try? APIRouter.movieQuery(query: q, page: params.page).asURLRequest()
            
        } else if params.type == .discover {
            url = try? APIRouter.movieDiscover(page: params.page).asURLRequest()
        }
        
        guard let requestUrl = url else {
            errorMessage("Request URL error")
            return
        }
        
        Alamofire.request(requestUrl).responseJSON { (response) in
            
            if let error = response.error {
                errorMessage("Error getting response from server. \(error.localizedDescription)")
                return
            }
            
            if let data = response.data {

                do {
                    let decoder = JSONDecoder()
                    let queryResult = try decoder.decode(QueryResult.self, from: data)

                    success(queryResult.results, queryResult.totalPages)
                } catch {
                    print("\(error.localizedDescription) - JSON decoder fail with data: \(String(data: data, encoding: .utf8) ?? "")")
                    errorMessage("Error parsing JSON")
                }
            }
            
        }
    }
    
    func downloadImage(_ imagePath: String, withSize size: Int, success: @escaping (UIImage) -> Void, error: @escaping (String) -> Void) -> Void {
	
        guard let url = try? APIRouter.image(size: size, path: imagePath).asURLRequest() else { return }
        
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
