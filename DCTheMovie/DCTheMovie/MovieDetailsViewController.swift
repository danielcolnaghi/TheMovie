//
//  MovieDetailsViewController.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/22/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
	
	@IBOutlet weak var imgCover: UIImageView!
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var txtOverview: UITextView!
	
	var viewModel : MovieDetailViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		viewModel.movie.loadBackdropImage(success: { (image) in
			self.imgCover.image = image
		})
		
		lblTitle.text = viewModel.movie.title
		txtOverview.text = viewModel.movie.overview
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}
