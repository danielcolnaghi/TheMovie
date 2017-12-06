//
//  MyMovieCell.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 01/12/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MyMovieCell : UITableViewCell {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    private var movieId = 0
    
    func loadCellWithMovie(_ movie : Movie) {
        
        self.lblTitle.text = movie.title
        self.movieId = movie.id
        
        if self.reuseIdentifier == "moviecell" {
            movie.loadBackdropImage { (image) in

                if movie.id == self.movieId {
                    self.imgBackground.image = image
                }

            }
        }
    }
}
