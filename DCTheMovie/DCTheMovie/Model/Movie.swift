//
//  Movie.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 20/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

struct Movie: Codable {
    let id : Int
    let title : String?
    var overview : String?
    var coverPath : String?
	var voteAvarage : Decimal?
	let releaseDate : String
	var backdropPath : String?
    var budget : Int?
    var revenue : Int?
    var runtime : Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case coverPath = "poster_path"
        case voteAvarage = "vote_average"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case budget
        case revenue
        case runtime
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

extension Movie : Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func != (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id != rhs.id
    }
}

extension Movie : Hashable {
    var hashValue: Int {
        return id.hashValue
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
