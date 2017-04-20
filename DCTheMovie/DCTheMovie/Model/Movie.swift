//
//  Movie.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 20/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation

class Movie {
    var title : String
    var description : String
    var coverPath : String
    
    init(dic : Dictionary<String, Any>) {
        
        title = dic["title"] as! String
        description = dic["description"] as! String
        coverPath = dic["cover"] as! String
        
    }
}
