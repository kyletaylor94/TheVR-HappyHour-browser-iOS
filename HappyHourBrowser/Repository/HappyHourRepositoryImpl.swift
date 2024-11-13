//
//  HappyHourRepository.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 30..
//

import Foundation
import CoreData

@MainActor
class HappyHourRepositoryImpl: HappyHourRepository {
    
    private var apiService: HappyHourApiService {
        guard let apiService = DependencyContainer.shared.container.resolve(HappyHourApiService.self) else {
            preconditionFailure("DEBUG: Failed to resolve \(HappyHourApiService.self)")
        }
        return apiService
    }
    
    private var storageService: HappyHourStorageService {
        guard let storageService = DependencyContainer.shared.container.resolve(HappyHourStorageService.self) else {
            preconditionFailure("DEBUG: Failed to resolve \(HappyHourStorageService.self)")
        }
        return storageService
    }
    
    //MARK: - ApiService
    func fetchFromApiService(targetPage: Int) async throws -> HappyHourPageModel {
        return try await apiService.getLoadHappyHourPage(targetPage: targetPage)
    }
    
    //MARK: - DBService
    
    func fetchFromCoreData(query: String, option: SearchOption) async throws -> [HappyHourVideoModel]? {
        
        let predicate: NSPredicate
        
        switch option {
          case .byPart:
              predicate = NSPredicate(format: "part == %@", query)
          case .byDate:
              predicate = NSPredicate(format: "publishedDate == %@", query)
          case .byText:
              predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
          }
        return try await storageService.fetchFromCoreData(with: predicate)
    }
    
    
    func saveToCoreData(video: HappyHourVideoModel) async throws {
       try await storageService.saveHappyHourVideo(video: video)
    }
    
    func syncEpisodesWithCoreData(allvideos: [HappyHourVideoModel]) async throws {
        for video in allvideos {
            try await saveToCoreData(video: video)
        }
    }
}
