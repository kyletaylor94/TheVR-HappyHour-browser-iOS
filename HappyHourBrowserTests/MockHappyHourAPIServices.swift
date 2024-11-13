//
//  MockHappyHourAPIServices.swift
//  HappyHourBrowserTests
//
//  Created by Turdesan Csaba on 2024. 11. 07..
//

import XCTest
import Foundation
import Moya
@testable import HappyHourBrowser

@MainActor
final class MockHappyHourAPIServicesTest: XCTestCase {
    
    private var viewModel: HappyHourViewModel!
    private var mockApiService: MockHappyHourApiService!
    private let provider = MoyaProvider<HappyHourAPI>()
    
    override func setUp() {
        super.setUp()
        let container = DependencyContainerForTests.shared.container
        viewModel = container.resolve(HappyHourViewModel.self)
        mockApiService = container.resolve(MockHappyHourApiService.self)
    }
    
    func testLoadPageSuccess() async {
        mockApiService.shouldThrowError = false
        
        await viewModel.loadPage(targetPage: 1)
        
        XCTAssertFalse(viewModel.apiIsLoading)
        XCTAssertFalse(viewModel.hasApiError)
        XCTAssertTrue(viewModel.allVideos.count > 0)
    }
    
    func testLoadPageFailure() async {
        mockApiService.shouldThrowError = true
        await viewModel.loadPage(targetPage: 1)
        
        XCTAssertFalse(viewModel.apiIsLoading)
        XCTAssertTrue(viewModel.hasApiError)
       // XCTAssertEqual(viewModel.apiErrorType, .networkError) // Adjust based on your error handling

    }
    
    
    
}
