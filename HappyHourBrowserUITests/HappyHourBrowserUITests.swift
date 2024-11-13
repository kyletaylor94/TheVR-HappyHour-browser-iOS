//
//  HappyHourBrowserUITests.swift
//  HappyHourBrowserUITests
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import XCTest

final class HappyHourBrowserUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    @MainActor
    func testAppLaunchAndInitialState() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testAppWhenLoadedContent() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchButton = app.buttons["searchButton"]
        let backgroundPic = app.otherElements["backgroundPicture"]
        
        XCTAssert(searchButton.exists)
        XCTAssert(backgroundPic.exists)
    }
    

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
