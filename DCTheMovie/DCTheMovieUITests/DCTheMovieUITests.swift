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
        
        let theMoviesButton = app.navigationBars["The Movies"].buttons["The Movies"]
        app.tables.staticTexts["?!?!?"].tap()
        theMoviesButton.tap()
        
        let tablesQuery = app.tables
        let cancelButton = tablesQuery.buttons["Cancel"]
        cancelButton.tap()
    }

    func testMyMovies() {
        
        let app = XCUIApplication()
        app.launchArguments.append("STUBS")
        app.launch()
        
        let theMoviesButton = app.navigationBars["The Movies"].buttons["The Movies"]
        
        app.tables.staticTexts["Zombie Strippers!"].tap()
        app.buttons["I Must Watch"].tap()
        theMoviesButton.tap()
        
        let tabBarsQuery = app.tabBars
        let myMoviesButton = tabBarsQuery.buttons["My Movies"]
        myMoviesButton.tap()
        app.tables.staticTexts["Zombie Strippers!"].tap()

        let myMoviesButtonBack = app.navigationBars["DCTheMovie.MovieDetailsView"].buttons["My Movies"]
        myMoviesButtonBack.tap()
        app.tables.staticTexts["Zombie Strippers!"].swipeLeft()
        app.tables.buttons["Delete"].tap()
    }
}
