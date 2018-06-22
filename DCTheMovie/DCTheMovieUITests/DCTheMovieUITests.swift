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
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Zombie Strippers!"]/*[[".cells.staticTexts[\"Zombie Strippers!\"]",".staticTexts[\"Zombie Strippers!\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let detailsNavigationBar = app.navigationBars["Details"]
        let button = detailsNavigationBar.children(matching: .button).element(boundBy: 1)
        button.tap()
        button.tap()
        
        let theMoviesButton = detailsNavigationBar.buttons["The Movies"]
        theMoviesButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Zombie Bite 2"]/*[[".cells.staticTexts[\"Zombie Bite 2\"]",".staticTexts[\"Zombie Bite 2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.orientation = .landscapeLeft
        XCUIDevice.shared.orientation = .portrait
        button.tap()
        button.tap()
        theMoviesButton.tap()
    }
    
    func testSearchBar() {
        
        let app = XCUIApplication()
        app.launchArguments.append("STUBS")
        app.launch()
        
        app.tables.staticTexts["?!?!?"].swipeDown()
        
        let searchForZombiesOrMoviesSearchField = app.searchFields["search for zombies or movies"]
        searchForZombiesOrMoviesSearchField.tap()
        searchForZombiesOrMoviesSearchField.typeText("zombies")
        app.typeText("\r")
        searchForZombiesOrMoviesSearchField.tap()

        let theMoviesButton = app.navigationBars["Details"].buttons["The Movies"]
        app.tables.staticTexts["?!?!?"].tap()
        theMoviesButton.tap()

        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
    }

    func testMyMovies() {
        
        let app = XCUIApplication()
        app.launchArguments.append("STUBS")
        app.launch()
        
        let theMoviesButton = app.navigationBars["Details"].buttons["The Movies"]
        
        app.tables.staticTexts["Zombie Strippers!"].tap()
        app.navigationBars["Details"].children(matching: .button).element(boundBy: 1).tap()
        theMoviesButton.tap()
        
        let tabBarsQuery = app.tabBars
        let myMoviesButton = tabBarsQuery.buttons["Must Watch"]
        myMoviesButton.tap()
        app.tables.staticTexts["Zombie Strippers!"].tap()

        let myMoviesButtonBack = app.navigationBars["Details"].buttons["Must Watch"]
        myMoviesButtonBack.tap()
        app.tables.staticTexts["Zombie Strippers!"].swipeLeft()
        app.tables.buttons["Delete"].tap()
        
    }
    
    func testWatchedList() {
        
        let app = XCUIApplication()
        app.launchArguments.append("STUBS")
        app.launch()
        
        let theMoviesButton = app.navigationBars["Details"].buttons["The Movies"]
        
        app.tables.staticTexts["Zombie Strippers!"].tap()
        app.navigationBars["Details"].children(matching: .button).element(boundBy: 1).tap()
        theMoviesButton.tap()
        
        let tabBarsQuery = app.tabBars
        let myMoviesButton = tabBarsQuery.buttons["Must Watch"]
        myMoviesButton.tap()
        app.tables.staticTexts["Zombie Strippers!"].tap()
        
        let myMoviesButtonBack = app.navigationBars["Details"].buttons["Must Watch"]
        myMoviesButtonBack.tap()
        app.tables.staticTexts["Zombie Strippers!"].swipeLeft()
        app.tables.buttons["Watched"].tap()
        
        let watchedButton = tabBarsQuery.buttons["Watched"]
        watchedButton.tap()
        
        app.tables.staticTexts["Zombie Strippers!"].tap()
        let watchedButtonBack = app.navigationBars["Details"].buttons["Watched"]
        watchedButtonBack.tap()
        
        app.tables.staticTexts["Zombie Strippers!"].swipeLeft()
        app.tables.buttons["Remove"].tap()
        
        sleep(1)
    }
    
    func testAbout() {
        
        let app = XCUIApplication()
        app.launchArguments.append("STUBS")
        app.launch()
        
        let tabBarsQuery = app.tabBars
        let myMoviesButton = tabBarsQuery.buttons["About"]
        myMoviesButton.tap()
    }
    
    func testAPI() {
        
        let app = XCUIApplication()
        app.launch()
        
        sleep(1)
        
        for x in 0...5 {
            app.tables.cells.element(boundBy: x*5).firstMatch.swipeUp()
        }

        sleep(1)
    }
}
