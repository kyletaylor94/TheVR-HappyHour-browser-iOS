//
//  HappyHourViewModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import Foundation
import CoreData
import SwiftUI

enum ApiError: Error, LocalizedError {
    case badUrl
    case noData
    case invalidResponse(statusCode: Int)
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "The URL provided was invalid."
        case .noData:
            return "No data was received from the server."
        case .invalidResponse(let statusCode):
            return "Received an invalid response from the server with statuscode: \(statusCode)"
        case .decodingError:
            return "Failed to deccode the response data."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}

@MainActor
class HappyHourViewModel: ObservableObject {
    @Published var apiErrorType: ApiError?
    @Published var hasError: Bool = false
    @Published var isLoading = true
    
    @Published var currentPage: Int = -8
    @Published var totalSearchPages: Int = 1740
    @Published var page: HappyHourPageModel?
    @Published var allVideos: [HappyHourVideoModel] = []
    
    @Published var searchResults: [HappyHourVideoModel] = []


    private let service = ApiService.shared
    private let managedObjectContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    func loadPage(targetPage: Int) async {
        defer { isLoading = false }
        
        do {
            let page = try await service.loadHappyHourPage(targetPage: targetPage)
            self.page = page
            self.allVideos.append(contentsOf: page.hhVideos)
            apiErrorType = nil
        } catch let apiError as ApiError {
            apiErrorType = apiError
            hasError = true
        } catch{
            apiErrorType = .unknown(error)
            hasError = true
            print("Unknown Error: \(error.localizedDescription)")
        }
    }
    
    func loadNextPage() async {
        self.currentPage += 8
        await loadPage(targetPage: currentPage)
    }
    
    func searchEpisodes(option: SearchOption ,query: String) async -> [HappyHourVideoModel] {
        searchResults = []
        
        if let cachedResults = await fetchFromCoreData(query: query, option: option) {
            if !cachedResults.isEmpty {
                searchResults = cachedResults
                return searchResults
            }
        }
        
        var morePagesAvailable = true
        
        while morePagesAvailable {

            isLoading = true
            await loadNextPage()
            
            switch option {
                case .byPart:
                if let partNumber = Int(query), partNumber > totalSearchPages - 8 {
                        return searchResults
                    }
                    searchResults = allVideos.filter { String($0.part) == query }
                    
                case .byDate:
                    searchResults = allVideos.filter { FormatHelper.formatDate($0.publishedDate) == query }
                    
                case .byText:
                    let result = allVideos.filter({ $0.title.lowercased().contains(query.lowercased()) })
                    searchResults.append(contentsOf: result)
            }
            
            if !searchResults.isEmpty {
                isLoading = false
                return searchResults
            }
            
            morePagesAvailable = hasMorePages()
        }
        isLoading = false
        return searchResults
    }
    
    
    func hasMorePages() -> Bool {
        return currentPage < totalSearchPages
    }
    
    func syncEpisodesWithCoreData() async {
        do {
            let page = try await service.loadHappyHourPage(targetPage: currentPage)
            for video in page.hhVideos {
                await saveHappyHourVideo(video: video)
            }
        } catch {
            print("Sync failed with error: \(error.localizedDescription)")
            apiErrorType = .unknown(error)
            hasError = true
        }
    }
    
    func saveHappyHourVideo(video: HappyHourVideoModel) async {
        guard !allVideos.isEmpty else { return }
        let fetchRequest = NSFetchRequest<HappyHourEntity>(entityName: "HappyHourEntity")
          fetchRequest.predicate = NSPredicate(format: "id == %d", video.id)
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            
            if results.isEmpty {
                let happyHourEntity = HappyHourEntity(context: managedObjectContext)
                
                happyHourEntity.title = video.title
                happyHourEntity.id = Int64(video.id)
                happyHourEntity.part = Int64(video.part)
                happyHourEntity.publishedDate = video.publishedDate
                happyHourEntity.videoCoverImg = video.videoCoverImg
                happyHourEntity.timeStampText = video.timeStampText
                
                try managedObjectContext.save()
                print("video saved successfully!")
            } else {
                print("video already exists skipping save")
            }
        } catch {
            print("Failed to check/save video: \(error.localizedDescription)")
        }
    }
    
    
    func fetchFromCoreData(query: String, option: SearchOption) async -> [HappyHourVideoModel]? {
        let fetchRequest = NSFetchRequest<HappyHourEntity>(entityName: "HappyHourEntity")
        
        switch option {
            case .byPart:
                fetchRequest.predicate = NSPredicate(format: "part == %@", query)
            case .byDate:
                fetchRequest.predicate = NSPredicate(format: "publishedDate == %@", query)
            case .byText:
                fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
        }
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            let models = results.compactMap { HappyHourVideoModel(entity: $0) }
            print("First Model is: \(models.first)")
            return models
            
        } catch {
            print("Failed to fetch from CoreData: \(error.localizedDescription)")
            return nil
        }
    }
}
