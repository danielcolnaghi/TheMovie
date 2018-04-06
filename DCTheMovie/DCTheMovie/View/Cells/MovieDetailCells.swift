//
//  MovieBackdropCell.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 21/03/18.
//  Copyright © 2018 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

protocol MovieCellBase {
    var model: Movie? {get set}
}

class MovieBackdropCell : UITableViewCell, MovieCellBase {
    
    @IBOutlet var imgBackdrop: UIImageView!
    
    var model: Movie? {
        didSet {
            model?.loadBackdropImage(success: { (image) in
                self.imgBackdrop.image = image
            })
        }
    }
}

class MovieTitleCell : UITableViewCell, MovieCellBase {
    @IBOutlet var lblTitle: UILabel!
    
    var model: Movie? {
        didSet {
            lblTitle.text = model?.title
        }
    }
}

class MovieDetailsCell : UITableViewCell, MovieCellBase {
    @IBOutlet var lblRuntime: UILabel!
    @IBOutlet var lblBudget: UILabel!
    @IBOutlet var lblReleased: UILabel!
    @IBOutlet var lblRevenue: UILabel!
    
    var model: Movie? {
        didSet {
            lblRuntime.text = model?.runtime?.toRuntime()
            lblBudget.text = model?.budget?.toUSCurrency()
            lblReleased.text = model?.releaseDate
            lblRevenue.text = model?.revenue?.toUSCurrency()
        }
    }
}

class MovieDescriptionCell : UITableViewCell, MovieCellBase {
    @IBOutlet var lblDescription: UILabel!
    
    var model: Movie? {
        didSet {
            lblDescription.text = model?.overview
            lblDescription.sizeToFit()
        }
    }
}
