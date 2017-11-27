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
    
    func testTableViewAndDetails() {
        
        let app = XCUIApplication()
        app.launchArguments.append("STUBS")
        app.launch()

        let theMoviesButton = app.navigationBars["The Movies"].buttons["The Movies"]
        
        app.tables.staticTexts["?!?!?"].tap()
        theMoviesButton.tap()

        app.tables.staticTexts["Zombie Bite"].tap()
        theMoviesButton.tap()
        
        app.tables.staticTexts["White Zombie"].tap()
        theMoviesButton.tap()
        
        app.tables.staticTexts["Zombie Strippers!"].tap()
        theMoviesButton.tap()
    }
    
    
    func testSearchBar() {
        
        let app = XCUIApplication()
        app.launchArguments.append("STUBS")
        app.launch()
        
        let searchForZombiesOrMoviesSearchField = app.tables.searchFields["search for zombies or movies"]
        searchForZombiesOrMoviesSearchField.tap()
        searchForZombiesOrMoviesSearchField.typeText("zombies")
        app.typeText("\r")
        searchForZombiesOrMoviesSearchField.tap()
        
        
    }

}
