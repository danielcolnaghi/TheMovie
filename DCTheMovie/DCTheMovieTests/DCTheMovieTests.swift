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
        MovieAPI().moviesFromPage(1, success: { (movies) in
            XCTAssert(movies.count == 5, "Valid return from API")
            exp.fulfill()
        }) { (error) in
            XCTFail("Error loading movies from API")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMoviesFromPageError() {
        let exp = expectation(description: "Get data from stubs")
        stubRequestFor(path: "/movie", jsonFile: "invalid.json")
        MovieAPI().moviesFromPage(1, success: { (movies) in
            XCTFail("This test should fail!")
            exp.fulfill()
        }) { (error) in
            XCTAssert(error != "", "Json is invalid - error: \(error)")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMoviesSearch() {
        let exp = expectation(description: "Get data from stubs")
        stubRequestFor(path: "/movie", jsonFile: "movies.json")
        MovieAPI().moviesSearch(To:"zombie", page: 1, success: { (movies) in
            XCTAssert(movies.count == 5, "Valid return from API")
            exp.fulfill()
        }) { (error) in
            XCTFail("Error loading movies from API")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testMoviesSearchError() {
        let exp = expectation(description: "Get data from stubs")
        stubRequestFor(path: "/movie", jsonFile: "invalid.json")
        MovieAPI().moviesSearch(To:"zombie", page: 1, success: { (movies) in
            XCTFail("This test should fail!")
            exp.fulfill()
        }) { (error) in
            XCTAssert(error != "", "Json is invalid - error: \(error)")
            exp.fulfill()
        }
        
        waitForIt()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
