//
//  HappyHourBrowserTests.swift
//  HappyHourBrowserTests
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import XCTest
@testable import HappyHourBrowser

final class FormatHelperTests: XCTestCase {

    func testFormattedTitle() {
        let title1 = "Happy Hour | Enjoy drinks with friends"
        let title2 = "Just a simple title"
        
        XCTAssertEqual(FormatHelper.formattedTitle(title1), "Happy Hour")
        XCTAssertEqual(FormatHelper.formattedTitle(title2), "Just a simple title")
        XCTAssertEqual(FormatHelper.formattedTitle(""), "")
    }
    
    func testFormatDate() {
        let dateString1 = "2024-10-06 14:30:00"
        let dateString2 = "2024-10-06 00:00:00"
        let dateStringInvalid = "invalid-date-string"
        
        XCTAssertEqual(FormatHelper.formatDate(dateString1), "2024-10-06")
        XCTAssertEqual(FormatHelper.formatDate(dateString2), "2024-10-06")
        XCTAssertEqual(FormatHelper.formatDate(dateStringInvalid), "")
    }
    
    func testConvertToSeconds() {
        let timestamp1 = "02:30:01"
        let timestamp2 = "02:30:02"
        let timestampInvalid = "invalid-timestamp"
        
        XCTAssertEqual(FormatHelper.convertToSeconds(from: timestamp1), 9001)
        XCTAssertEqual(FormatHelper.convertToSeconds(from: timestamp2), 9002)
        XCTAssertEqual(FormatHelper.convertToSeconds(from: timestampInvalid), 0)
        XCTAssertEqual(FormatHelper.convertToSeconds(from: "02:30:00"), 9000)
        XCTAssertEqual(FormatHelper.convertToSeconds(from: "00:00:30"), 30)
    }
    
    func testYoutubeChapterUrl() {
        let timeStamp = "01:30:45"
        let videoId = "abc123"
        
        let expectedUrl = "https://www.youtube.com/watch?v=abc123&t=5445s"
        XCTAssertEqual(FormatHelper.youtubeChapterUrl(for: timeStamp, for: videoId), expectedUrl)
    }
    
    func testExtractTimeStamp() {
        let chapter1 = "00:01:30 - Introduction"
        let chapter2 = "00:00:00 - Start"
        
        XCTAssertEqual(FormatHelper.extractTimeStamp(from: chapter1), "00:01:30")
        XCTAssertEqual(FormatHelper.extractTimeStamp(from: chapter2), "00:00:00")
    }
    
    func testYoutubeThumbnailUrl() {
        let videoId = "abc123"
        let expectedUrl = "https://img.youtube.com/vi/abc123/0.jpg"
        XCTAssertEqual(FormatHelper.youtubeThumbnailUrl(videoId: videoId), expectedUrl)
    }
    
}


//override func setUpWithError() throws {
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//}
//
//override func tearDownWithError() throws {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//}
//
//func testExample() throws {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    // Any test you write for XCTest can be annotated as throws and async.
//    // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//    // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//}
//
//func testPerformanceExample() throws {
//    // This is an example of a performance test case.
//    self.measure {
//        // Put the code you want to measure the time of here.
//    }
//}
