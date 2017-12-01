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
    
    func loadCellWithMovie(_ movie : Movie) {
        
        self.lblTitle.text = movie.title
        self.imgBackground.image = nil
        
        if self.reuseIdentifier == "moviecell" {
            movie.loadBackdropImage { (image) in
                self.imgBackground.image = image
            }
        }
    }
}
