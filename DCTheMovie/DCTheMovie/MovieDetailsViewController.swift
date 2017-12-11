//
//  MovieDetailsViewController.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/22/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
	
    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var txtOverview: UITextView!
	
    @IBOutlet var imgCoverWidth: NSLayoutConstraint!
    @IBOutlet var imgBackdropHeight: NSLayoutConstraint!
    
    @IBOutlet var lblRuntime: UILabel!
    @IBOutlet var lblBudget: UILabel!
    @IBOutlet var lblRevenue: UILabel!
    @IBOutlet var lblReleasedDate: UILabel!
    
    var movieDetailVM : MovieDetailViewModel!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
		movieDetailVM.movie.loadBackdropImage(success: { (image) in
			self.imgBackdrop.image = image
		})

        movieDetailVM.movie.loadCoverImage(success: { (image) in
            self.imgCover.image = image
        })
        
		lblTitle.text = movieDetailVM.movie.title
		txtOverview.text = movieDetailVM.movie.overview
        txtOverview.contentOffset = CGPoint.zero
        lblReleasedDate.text = movieDetailVM.movie.releaseDate
        
        movieDetailVM.loadDetails {
            self.lblBudget.text = "\(self.movieDetailVM.movie.budget.toUSCurrency())"
            self.lblRevenue.text = "\(self.movieDetailVM.movie.revenue.toUSCurrency())"
            self.lblRuntime.text = "\(self.movieDetailVM.movie.runtime.toRuntime())"
        }
	}
    
    @IBAction func backgropImageTap(_ sender: Any) {
        self.imgBackdropHeight.constant = self.imgBackdropHeight.constant == 170 ? 280 : 170
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func coverImageTap(_ sender: Any) {
        self.imgCoverWidth.constant = self.imgCoverWidth.constant == 160 ? 80 : 160
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func addMovie(_ sender: Any) {
        MyMoviesViewModel().addMovie(movieDetailVM.movie)
    }
}
