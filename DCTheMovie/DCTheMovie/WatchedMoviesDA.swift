//
//  WatchedMoviesDA.swift
//  DCTheMovie
//
//  Created by Daniel Colnaghi on 19/06/18.
//  Copyright © 2018 Cold Mass Digital Entertainment. All rights reserved.
//

import Foundation

class WatchedMoviesDA {
    
    static var shared = WatchedMoviesDA()
    private var store = UserDefaults.standard
    private let STORE_KEY = "WatchedMovies"
    
    private init() {}
    
    func updateMovies(_ movies: [Movie]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(movies)
            store.set(data, forKey: STORE_KEY)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadMovies() -> [Movie]? {
        
        if let myMovies = UserDefaults.standard.object(forKey: STORE_KEY) as? Data {
            
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
