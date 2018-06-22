//
//  APIRouter.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 20/06/18.
//  Copyright © 2018 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case image(size: Int, path: String)
    case movie(id: Int)
    case movieQuery(query: String, page: Int)
    case movieDiscover(page: Int)
    
    private var method: HTTPMethod {
        switch self {
        case .image, .movie, .movieQuery, .movieDiscover:
            return .get
        }
    }
    
    private var baseURL: URL {
        switch self {
        case .movie:
            return URL(string: "\(K.TheMovieServer.baseURL)?\(K.APIParameterKey.apiKey)=\(K.TheMovieServer.apiKey)")!
        case .image(let size, _):
            return URL(string: "\(K.TheMovieServer.imageURL)\(size)")!
        case .movieQuery(let query, let page):
            return URL(string: "\(K.TheMovieServer.baseURL)?\(K.APIParameterKey.apiKey)=\(K.TheMovieServer.apiKey)&\(K.APIParameterKey.query)=\(query)&\(K.APIParameterKey.page)=\(page)")!
        case .movieDiscover(let page):
            return URL(string: "\(K.TheMovieServer.baseURL)?\(K.APIParameterKey.apiKey)=\(K.TheMovieServer.apiKey)&\(K.APIParameterKey.page)=\(page)")!
        }
    }
    
    private var path: String {
        switch self {
        case .image(_, let path):
            return "\(path)"
        case .movie(let id):
            return "/movie/\(id)"
        case .movieQuery:
            return "/search/movie"
        case .movieDiscover:
            return "/discover/movie"
        }
    }
    
//    private var parameters: Parameters? {
//        switch self {
//        case .somemethodwithparameters:
//        return [String: Any]
//        case .image, .movie, .movieQuery, .movieDiscover:
//            return nil
//        }
//    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
//        if let parameters = parameters {
//            do {
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            } catch {
//                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//            }
//        }
        
        return urlRequest
    }
}
