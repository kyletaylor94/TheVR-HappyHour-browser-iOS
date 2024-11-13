//
//  DependencyContainer.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 12..
//

import Foundation
import Swinject

@MainActor
class DependencyContainer {
    static let shared = DependencyContainer()
    let container = Container()
    
    private init() {
        registerhappyHourDependencies()
        registerSpotifyDependencies()
    }
    
    private func registerhappyHourDependencies() {
        container.register(HappyHourApiService.self) { _ in
           return HappyHourApiServiceImpl()
        }.inObjectScope(.container)
        
        container.register(HappyHourStorageService.self) { _ in
            return HappyHourStorageServiceImpl()
        }.inObjectScope(.container)
        
        container.register(HappyHourRepository.self) { _ in
            return HappyHourRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(HappyHourInteractor.self) { _ in
            return HappyHourInteractorImpl()
        }.inObjectScope(.container)
        
        
        container.register(HappyHourViewModel.self) { _ in
            return HappyHourViewModel()
        }.inObjectScope(.transient)
    }
    
    private func registerSpotifyDependencies() {
        container.register(SpotifyInteractor.self) { _ in
            return SpotifyInteractorImpl()
        }.inObjectScope(.container)
        
        container.register(SpotifyRepository.self) { _ in
            return SpotifyRepositoryImpl()
        }.inObjectScope(.container)
        
        container.register(SpotifyViewModel.self) { _ in
            return SpotifyViewModel()
        }.inObjectScope(.transient)
    }
    
}
