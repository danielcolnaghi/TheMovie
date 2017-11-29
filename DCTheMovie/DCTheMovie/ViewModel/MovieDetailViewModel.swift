//
//  MovieDetailViewModel.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/23/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MovieDetailViewModel {
	
	var movie : Movie
	
	init(movie : Movie) {
		self.movie = movie
	}
    
    func loadDetails(success: @escaping () -> Void) {

        MovieAPI().movieDetailsWithId(movie.id, success: { (responseMovie) in

            self.movie.budget = 100000
            
            success()
        }) { (error) in
            // TODO: alert user to retry
        }
    }

}
