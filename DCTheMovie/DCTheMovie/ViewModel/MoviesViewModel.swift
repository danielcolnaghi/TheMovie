//
//  MovieViewModel.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/22/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

class MoviesViewModel {

	var movies: [Movie] = [Movie]()
    var page: Int = 1
	
	init() {
		
	}
	
    func loadMovies(success: @escaping () -> Void) {
        MovieAPI().moviesFromPage(self.page, success: { (responseMovies) in
			self.movies.append(contentsOf: responseMovies)
			success()
		}, error: { (error) in
			// TODO: alert user to retry
		})
	}
	
    func loadMoreMovies(success: @escaping () -> Void) {
        self.page += self.page < Int.max ? 1 : 0
		self.loadMovies { () in
			success()
		}
	}
}
