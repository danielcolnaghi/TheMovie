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
	
    @IBOutlet var lblRuntime: UILabel!
    @IBOutlet var lblBudget: UILabel!
    @IBOutlet var lblRevenue: UILabel!
    @IBOutlet var lblReleasedDate: UILabel!
    
    var movieDetailVM : MovieDetailViewModel!
    private var movie : Movie!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        movie = movieDetailVM.movie
        
		movie.loadBackdropImage(success: { (image) in
			self.imgBackdrop.image = image
		})

        movie.loadCoverImage(success: { (image) in
            self.imgCover.image = image
        })
        
		lblTitle.text = movie.title
		txtOverview.text = movie.overview
        lblReleasedDate.text = movie.releaseDate
        lblBudget.text = "\(movie.budget)"
        lblRevenue.text = "\(movie.revenue)"
        lblRuntime.text = "\(movie.runtime)"
	}
}
