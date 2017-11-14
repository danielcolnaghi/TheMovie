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

        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
                
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["I Walked with a Zombie"]/*[[".cells.staticTexts[\"I Walked with a Zombie\"]",".staticTexts[\"I Walked with a Zombie\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let theMoviesButton = app.navigationBars["Movie"].buttons["The Movies"]
        theMoviesButton.tap()
        
        let zombieSpringBreakersStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Zombie Spring Breakers"]/*[[".cells.staticTexts[\"Zombie Spring Breakers\"]",".staticTexts[\"Zombie Spring Breakers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        zombieSpringBreakersStaticText.tap()
        theMoviesButton.tap()
        
        
        
    }
    
}
