//
//  QueryResult.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 30/01/18.
//  Copyright © 2018 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation

struct QueryResult: Codable {
    
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
