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
    var total_results: Int
    var total_pages: Int
    var results: [Movie]
}
