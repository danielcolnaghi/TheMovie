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
    var store = UserDefaults.standard
    
    init() {
        reloadData()
    }

    func reloadData() {
        if let m = MyMoviesViewModel.MyMovies() {
            movies.removeAll()
            movies.append(contentsOf: m)
        }
    }
    
    func updateStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(movies)
            store.set(data, forKey: "MyMovies")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addMovie(_ movie : Movie) {
        
        if !hasMovie(movie) {
            movies.append(movie)
            updateStore()
        }
    }
    
    func removeMovie(_ movie : Movie) {
        if let index = movies.index(of: movie) {
            movies.remove(at: index)
            updateStore()
        }
    }
    
    func hasMovie(_ movie : Movie) -> Bool {
        return movies.contains(movie)
    }
    
    func countMovies() -> Int {
        return movies.count
    }
    
    func movieAtIndex(_ index: Int) -> Movie? {
        guard movies.count > 0 else { return nil }
        
        return movies[index]
    }
    
    static func MyMovies() -> [Movie]? {
        
        if let myMovies = UserDefaults.standard.object(forKey: "MyMovies") as? Data {

            let decode = JSONDecoder()
            do {
                let data = try decode.decode([Movie].self, from: myMovies)
                return data
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
}
