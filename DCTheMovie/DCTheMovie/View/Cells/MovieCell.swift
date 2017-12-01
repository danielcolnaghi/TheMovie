//
//  MovieCell.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/23/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MovieCell : UITableViewCell {

	@IBOutlet weak var imgBackground: UIImageView!
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var lblVote: UILabel!
	@IBOutlet weak var lblReleaseDate: UILabel!
	
	func loadCellWithMovie(_ movie : Movie) {

        self.lblTitle.text = movie.title
        self.lblVote.text = "Vote Avarage \(movie.voteAvarage)"
        self.lblReleaseDate.text = "\(movie.releaseDate)"
        self.imgBackground.image = nil
        
        if self.reuseIdentifier == "moviecell" {
            movie.loadCoverImage { (image) in
                self.imgBackground.image = image
            }
        }
	}
}
