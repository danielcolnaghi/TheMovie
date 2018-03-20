//
//  DCTheMovieTests.swift
//  DCTheMovieTests
//
//  Created by Daniel Colnaghi on 19/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import XCTest
@testable import DCTheMovie
import OHHTTPStubs

class DCTheMovieTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    func stubRequestFor(path:String, jsonFile:String) {
        stub(condition: pathEndsWith(path)) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile(jsonFile, type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }

    func waitForIt() {
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testMoviesFromPage() {
        let exp = expectation(description: "Get data from stubs")
        stubRequestFor(path: "/movie", jsonFile: "movies.json")
        
        let param = MovieParams(page: 1, query: "", type: "discover")
        MovieAPI().moviesWithParams(param, success: { (movies, pages) in
            XCTAssert(movies.count == 5, "Total movies test")
            XCTAssert(pages == 1, "Page count test")
            exp.fulfill()
        }) { (error) in
            XCTFail("Error loading movies from API")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMoviesSearch() {
        let exp = expectation(description: "Get data from stubs")
        stubRequestFor(path: "/movie", jsonFile: "movies.json")
        
        let param = MovieParams(page: 1, query: "", type: "search")
        MovieAPI().moviesWithParams(param, success: { (movies, pages) in
            XCTAssert(movies.count == 5, "Total movies test")
            XCTAssert(pages == 1, "Page count test")
            exp.fulfill()
        }) { (error) in
            XCTFail("Error loading movies from API")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMovieViewModel() {
        let exp = expectation(description: "Get data from stubs")
        stubRequestFor(path: "/movie", jsonFile: "movies.json")
        
       let mvm = MoviesViewModel()
        mvm.loadMovies {
            
            var count = mvm.countMovies()
            XCTAssert(count == 5, "Total movies from [Movies] is correct")
            
            if let movie = mvm.movieAtIndex(0) {
                XCTAssert(movie.title == "Zombie Strippers!", "Movie at index is correct")
            } else {
                XCTFail("It should return a movie")
            }
            
            mvm.removeAllMovies()
            count = mvm.countMovies()
            XCTAssert(count == 0, "Removed all itens from [Movies]")
            
            XCTAssert(mvm.movieAtIndex(0) == nil, "Removed all itens from [Movies]")
            
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMovieModelBackdropImage() {
        
        let exp = expectation(description: "Load image from invalid path")
        var movie : Movie!
        
        do {
            let decoder = JSONDecoder()
            let file = Bundle.main.path(forResource: "moviewrongimage", ofType: "json")
            let data = try String(contentsOfFile: file!).data(using: .utf8)
            movie = try decoder.decode(Movie.self, from: data!)
        } catch {
            
        }
        
        movie.loadBackdropImage { (image) in
            
            XCTAssert(image!.isEqual(UIImage(named: "wideplaceholder")), "Fail to load image, returned a placeholder")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMovieModelBackdropImageImageNotFound() {
        
        let exp = expectation(description: "Load image from invalid path")
        var movie : Movie!
        
        do {
            let decoder = JSONDecoder()
            let file = Bundle.main.path(forResource: "moviewrongimage", ofType: "json")
            let data = try String(contentsOfFile: file!).data(using: .utf8)
            movie = try decoder.decode(Movie.self, from: data!)
        } catch {
            
        }
        
        movie.loadBackdropImage { (image) in
            
            XCTAssert(image!.isEqual(UIImage(named: "wideplaceholder")), "Fail to load image, returned a placeholder")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMovieModelCoverImage() {
        
        let exp = expectation(description: "Load image from invalid path")
        var movie : Movie!
        
        do {
            let decoder = JSONDecoder()
            let file = Bundle.main.path(forResource: "moviewrongimage", ofType: "json")
            let data = try String(contentsOfFile: file!).data(using: .utf8)
            movie = try decoder.decode(Movie.self, from: data!)
        } catch {
            
        }
        movie.loadCoverImage { (image) in
            
            XCTAssert(image!.isEqual(UIImage(named: "coverplaceholder")), "Fail to load image, returned a placeholder")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMovieModelCoverImageImageNotFound() {
        
        let exp = expectation(description: "Load image from invalid path")
        var movie : Movie!
        
        do {
            let decoder = JSONDecoder()
            let file = Bundle.main.path(forResource: "moviewrongimage", ofType: "json")
            let data = try String(contentsOfFile: file!).data(using: .utf8)
            movie = try decoder.decode(Movie.self, from: data!)
        } catch {
            
        }
        movie.loadCoverImage { (image) in
            
            XCTAssert(image!.isEqual(UIImage(named: "coverplaceholder")), "Fail to load image, returned a placeholder")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            
            let mvm = MoviesViewModel()
            mvm.loadMovies {}
            
            stubRequestFor(path: "/movie", jsonFile: "movies.json")
            let param = MovieParams(page: 1, query: "", type: "search")
            MovieAPI().moviesWithParams(param, success: { (movies, pages) in }) { (error) in }
        }
    }
    
}
