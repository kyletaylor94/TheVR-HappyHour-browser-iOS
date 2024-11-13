//
//  DepedencyContainerForTests.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation
import Swinject

@MainActor
class DependencyContainerForTests {
    static let shared = DependencyContainerForTests()
    let container = Container()
    
    private init() {
        registerDependencies()
    }
    
    private func registerDependencies() {
        container.register(HappyHourApiService.self) { _ in
            return MockHappyHourApiService()
        }.inObjectScope(.container)
        
        container.register(HappyHourViewModel.self) { resolver in
            return HappyHourViewModel()
        }.inObjectScope(.transient)
    }
}
