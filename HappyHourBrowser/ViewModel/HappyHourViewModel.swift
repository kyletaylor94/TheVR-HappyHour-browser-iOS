//
//  HappyHourViewModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import Foundation
import CoreData
import SwiftUI
import Moya
import Combine

@MainActor
class HappyHourViewModel: ObservableObject {
    @Published var apiErrorType: ApiError?
    @Published var hasError: Bool = false
    @Published var isLoading = true
    
    @Published var currentPage: Int = -8
    @Published var totalSearchPages: Int?
    
    @Published var page: HappyHourPageModel?
    @Published var allVideos: [HappyHourVideoModel] = []
    
    @Published var searchResults: [HappyHourVideoModel] = []
    
    
    private let service = ApiService.shared
    private let managedObjectContext: NSManagedObjectContext
    
    private var cancellables = Set<AnyCancellable>()
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    func loadPage(targetPage: Int) async {
        defer { isLoading = false }
        
        await service.loadHappyHourPage(targetPage: targetPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.apiErrorType = error
                    self?.hasError = true
                    print(String(describing: error))
                }
            } receiveValue: { [weak self] page in
                self?.page = page
                self?.allVideos.append(contentsOf: page.hhVideos)
                self?.apiErrorType = nil
            }
            .store(in: &cancellables)
    }
    
    
    func loadNextPage() async {
        self.currentPage += 8
        await loadPage(targetPage: currentPage)
    }
    
    func searchEpisodes(option: SearchOption ,query: String) async -> [HappyHourVideoModel] {
        searchResults = []
        guard let totalSearchPages = allVideos.first?.part else { return [] }
        
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
        guard let totalSearchPages = allVideos.first?.part else { return false }
        return currentPage < totalSearchPages
    }
    
    func syncEpisodesWithCoreData() async {
        for video in allVideos {
            await saveHappyHourVideo(video: video)
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
            return models
            
        } catch {
            print("Failed to fetch from CoreData: \(error.localizedDescription)")
            return nil
        }
    }
}
