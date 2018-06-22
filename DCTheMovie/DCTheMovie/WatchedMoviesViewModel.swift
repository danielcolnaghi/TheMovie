//
//  WatchedMoviesViewModel.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 22/06/18.
//  Copyright © 2018 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation

class WatchedMoviesViewModel {
    
    private var movies : [Movie] = [Movie]()
    private var moviesDA = WatchedMoviesDA.shared
    
    init() {
        reloadData()
    }
    
    func reloadData() {
        if let m = moviesDA.loadMovies() {
            movies.removeAll()
            movies.append(contentsOf: m)
        }
    }
    
    func addMovie(_ movie : Movie) {
        
        if !hasMovie(movie) {
            movies.append(movie)
            moviesDA.updateMovies(movies)
        }
    }
    
    func removeMovie(_ movie : Movie) {
        if let index = movies.index(of: movie) {
            movies.remove(at: index)
            moviesDA.updateMovies(movies)
        }
    }
    
    func hasMovie(_ movie : Movie) -> Bool {
        return movies.contains(movie)
    }
    
    var countMovies: Int {
        return movies.count
    }
    
    //subscript
    func movieAtIndex(_ index: Int) -> Movie? {
        guard movies.count > 0 else { return nil }
        
        return movies[index]
    }
}
