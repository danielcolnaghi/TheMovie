//
//  MovieViewModel.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 4/22/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import UIKit

protocol AsyncResponse {
    func doneLoadMoreMovies()
}

class MoviesViewModel {
    
    var delegate: AsyncResponse?

	private var movies: [Movie] = [Movie]()
    var params = MovieParams(page: 1, query: "", type: "discover")
	
    func loadMovies(success: @escaping () -> Void) {
        
        MovieAPI().moviesWithParams(params, success: { (responseMovies) in
            self.movies.append(contentsOf: responseMovies)
            success()
        }) { (error) in
            // TODO: alert user to retry
        }
	}
	
    func loadMoreMovies(success: @escaping () -> Void) {
        self.params.page += 1
		self.loadMovies { () in
			success()
		}
	}
    
    func removeAllMovies() {
        movies.removeAll()
    }
    
    func countMovies() -> Int {
        return movies.count
    }
    
    func movieAtIndex(_ index: Int) -> Movie {
        
        // verify if there is more pages to load otherwise this will create an infinity loop
        if movies.count < index + 2 {
            loadMoreMovies {
                self.delegate?.doneLoadMoreMovies()
            }
        }
        
        return movies[index]
    }
}
