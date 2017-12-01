//
//  MovieDetailViewModel.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/23/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
	
	var movie : Movie
	
	init(movie : Movie) {
		self.movie = movie
	}
    
    func loadDetails(success: @escaping () -> Void) {

        MovieAPI().movieDetailsWithId(movie.id, success: { (responseMovie) in
            self.movie.budget = responseMovie.budget
            self.movie.revenue = responseMovie.revenue
            self.movie.runtime = responseMovie.runtime
            success()
        }) { (error) in
            // TODO: alert user to retry
        }
    }

}
