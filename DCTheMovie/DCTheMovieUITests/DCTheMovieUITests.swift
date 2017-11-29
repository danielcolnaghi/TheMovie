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
        
        
        
        
   /*
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let searchForZombiesOrMoviesSearchField = tablesQuery.searchFields["search for zombies or movies"]
        searchForZombiesOrMoviesSearchField.tap()
        searchForZombiesOrMoviesSearchField.typeText("zomb")
        app.typeText("\r")
        searchForZombiesOrMoviesSearchField.tap()
        searchForZombiesOrMoviesSearchField.tap()
        searchForZombiesOrMoviesSearchField.typeText("zomb")
        searchForZombiesOrMoviesSearchField.tap()
        
        let cancelButton = tablesQuery.buttons["Cancel"]
        cancelButton.tap()
        cancelButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Vote Avarage 5.6"]/*[[".cells.staticTexts[\"Vote Avarage 5.6\"]",".staticTexts[\"Vote Avarage 5.6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery.children(matching: .cell).element(boundBy: 7).staticTexts["2017-04-19"].swipeUp()
        */
    }

}
