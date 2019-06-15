//
//  MyMoviesViewModel.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 30/11/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation

class MyMoviesViewModel {
   
    private var movies : [Movie] = [Movie]()
    private var moviesDA = MustWatchMoviesDA.shared
    
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
        if let index = movies.firstIndex(of: movie) {
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
    
    func moveToWatchedList(Movie movie: Movie) {
        if var wathedMovies = WatchedMoviesDA.shared.loadMovies() {
            wathedMovies.append(movie)
            WatchedMoviesDA.shared.updateMovies(wathedMovies)
        } else {
            var wathedMovies = [Movie]()
            wathedMovies.append(movie)
            WatchedMoviesDA.shared.updateMovies(wathedMovies)
        }
    }
}
