//
//  Movie.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 20/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//
/* Expected format from SEARCH/DISCOVER

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
 
 Expected format from DETAILS
 
 {"adult":false,"backdrop_path":"/tcheoA2nPATCm2vvXw2hVQoaEFD.jpg","belongs_to_collection":null,"budget":35000000,
 "genres":[{"id":18,"name":"Drama"},{"id":14,"name":"Fantasy"},{"id":27,"name":"Horror"},{"id":53,"name":"Thriller"}],
 "homepage":"http://itthemovie.com/",
 "id":346364,
 "imdb_id":"tt1396484","original_language":"en","original_title":"It",
 "overview":"In a small town in Maine, seven children known as The Losers Club come face to face with life problems, bullies and a monster that takes the shape of a clown called Pennywise.",
 "popularity":927.851892,"poster_path":"/9E2y5Q7WlCVNEhP5GiVTjhEhx1o.jpg",
 "production_companies":[{"name":"New Line Cinema","id":12}, {"name":"Vertigo Entertainment","id":829},{"name":"Lin Pictures","id":2723},{"name":"RatPac-Dune Entertainment","id":41624},
 {"name":"KatzSmith Productions","id":87671}],
 "production_countries":[{"iso_3166_1":"US","name":"United States of America"}],"release_date":"2017-09-05",
 "revenue":555575232,"runtime":135,"spoken_languages":[{"iso_639_1":"da","name":"Dansk"}],"status":"Released","tagline":"Your fears are unleashed",
 "title":"It","video":false,"vote_average":7.3,"vote_count":4089}
 
*/

import UIKit

struct Movie: Codable {
    let id : Int
    let title : String?
    let overview : String?
    var coverPath : String?
	var voteAvarage : String
	let releaseDate : String
	var backdropPath : String?
    var budget : Int
    var revenue : Int
    var runtime : Int
    
    init(dic : Dictionary<String, Any>) {

        id = dic["id"] as? Int ?? 0
        title = dic["title"] as? String ?? ""
        overview = dic["overview"] as? String ?? ""

        budget = dic["budget"] as? Int ?? 0
        revenue = dic["revenue"] as? Int ?? 0
        runtime = dic["runtime"] as? Int ?? 0
        
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
            MovieAPI().downloadImage(path, withSize: 300, success: { (image) in
                success(image)
            }, error: {_ in
                success(UIImage(named: "coverplaceholder"))
            })
            
        } else {
            success(UIImage(named: "coverplaceholder"))
        }
	}

	func loadBackdropImage(success: @escaping (UIImage?) -> Void) -> Void {
		
		if let path = backdropPath {
            MovieAPI().downloadImage(path, withSize: 600, success: { (image) in
                success(image)
            }, error: {_ in
                success(UIImage(named: "wideplaceholder"))
            })
        } else {
            success(UIImage(named: "wideplaceholder"))
        }
	}
}

extension Int {
    func toUSCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.numberStyle = .currency
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            return formattedTipAmount
        } else {
            return ""
        }
    }
    
    func toRuntime() -> String {
        return "\(self/60)h \((self)%60)m"
    }
}
