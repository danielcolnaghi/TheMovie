//
//  Movie.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 20/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//
/* Expected format

["poster_path": /tWqifoYuwLETmmasnGHO7xBjEtt.jpg,
"backdrop_path": /6aUWe0GSl69wMTSWWexsorMIvwU.jpg,
"genre_ids": <__NSArrayI 0x17002a4e0>(14,10749),
"vote_count": 1883,
"overview": A live-action...,
"original_title": Beauty and the Beast,
"vote_average": 6.9,
"popularity": 136.40833,
"id": 321612,
"original_language": en,
"release_date": 2017-03-16,
"video": 0,
"title": Beauty and the Beast,
"adult": 0]
*/

import UIKit

struct Movie: Codable {
    let title : String?
    let overview : String?
    var coverPath : String?
	var voteAvarage : String
	let releaseDate : String
	var backdropPath : String?
    
    init(dic : Dictionary<String, Any>) {

        title = dic["title"] as? String ?? ""
        overview = dic["overview"] as? String ?? ""

        if let poster_path = dic["poster_path"] as? String {
            coverPath = poster_path
        }

        if let vote = dic["vote_average"] as? Float {
            voteAvarage = String(format: "%.1f", vote)
        } else {
            voteAvarage = "-"
        }

        releaseDate = dic["release_date"] as? String ?? ""

        if let back = dic["backdrop_path"] as? String {
            backdropPath = back
        }
    }
	
	func loadCoverImage(success: @escaping (UIImage?) -> Void) -> Void {

        if let path = coverPath {
            MovieAPI().downloadImage(path) { (data) in
                success(data)
            }
        } else {
            success(UIImage(named: "placeholder"))
        }
	}

	func loadBackdropImage(success: @escaping (UIImage?) -> Void) -> Void {
		
		if let path = backdropPath {
			MovieAPI().downloadImage(path) { (data) in
				success(data)
			}
        } else {
            success(UIImage(named: "placeholder"))
        }
	}
}

extension Movie {
    enum MyStructKeys: String, CodingKey {
        case title = "title"
        case overview = "overview"
    }
}
