//
//  DCTheMovieUITests.swift
//  DCTheMovieUITests
//
//  Created by Daniel Colnaghi on 19/04/17.
//  Copyright © 2017 Cold Mass Digital Entertainment. All rights reserved.
//

import XCTest

class DCTheMovieUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {

        let app = XCUIApplication()
        app.launchArguments.append("STUBS")
        app.launch()
        
        let theMoviesButton = app.navigationBars["Movie"].buttons["The Movies"]
                
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 2).staticTexts["Vote Avarage 0.0"].tap()
        theMoviesButton.tap()
        tablesQuery.children(matching: .cell).element(boundBy: 3).staticTexts["Vote Avarage 5.9"].tap()
        theMoviesButton.tap()
        tablesQuery.children(matching: .cell).element(boundBy: 0).staticTexts["Vote Avarage -"].tap()
        theMoviesButton.tap()
        
        
    }
    
}
