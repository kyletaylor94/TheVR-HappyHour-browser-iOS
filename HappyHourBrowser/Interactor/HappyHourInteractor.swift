//
//  HappyHourInteractorProtocol.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 01..
//

protocol HappyHourInteractor {
    func preloadCache(query: String, option: SearchOption) async throws -> [HappyHourVideoModel]?
    func checkResults(viewmodel: HappyHourViewModel,query: String,option: SearchOption) async throws -> [HappyHourVideoModel]?
    func searchEpisodes(viewModel: HappyHourViewModel, option: SearchOption, query: String) async throws -> [HappyHourVideoModel]
    
    func fetchApiData(targetPage: Int) async throws -> [HappyHourVideoModel]
    func loadNextPage(currentPage: Int) async throws -> (newPage: Int, videos: [HappyHourVideoModel])
    func hasMorePages(viewModel: HappyHourViewModel) -> Bool
    
    func saveVideoToCoreData(video: HappyHourVideoModel) async throws
    func syncEpisodesWithCoreData(allvideos: [HappyHourVideoModel]) async throws
}


@MainActor
class HappyHourInteractorImpl: @preconcurrency HappyHourInteractor {
    
    private var happyHourRepository: HappyHourRepository {
        guard let resolvedRepository = DependencyContainer.shared.container.resolve(HappyHourRepository.self) else {
            preconditionFailure("DEBUG: Failed to resolve \(HappyHourRepository.self)")
        }
        return resolvedRepository
    }

    
    func preloadCache(query: String, option: SearchOption) async throws -> [HappyHourVideoModel]? {
        return try await happyHourRepository.fetchFromCoreData(query: query, option: option)
    }
    
    func saveVideoToCoreData(video: HappyHourVideoModel) async throws {
       try await happyHourRepository.saveToCoreData(video: video)
    }
    
    func syncEpisodesWithCoreData(allvideos: [HappyHourVideoModel]) async throws {
        try await happyHourRepository.syncEpisodesWithCoreData(allvideos: allvideos)
    }
    
    func searchEpisodes(viewModel viewmodel: HappyHourViewModel, option: SearchOption, query: String) async throws -> [HappyHourVideoModel] {
        if let cachedResults = try await happyHourRepository.fetchFromCoreData(query: query, option: option) {
            if !cachedResults.isEmpty {
                print("DEBUG: Found Episode in CoreData!")
                return cachedResults
            }
        }
        
        var morePagesAvailable = true

        while morePagesAvailable {
            
            await viewmodel.loadNextPage()
            
            print("DEBUG: ALLVIDEOS COUNT: \(viewmodel.allVideos.count)")
            
            if let result = await checkResults(viewmodel: viewmodel, query: query, option: option) {
                if !result.isEmpty {
                    return result
                }
            }
            
            morePagesAvailable = hasMorePages(viewModel: viewmodel)

        }
        return []
    }
    
    
    func checkResults(viewmodel: HappyHourViewModel,query: String,option: SearchOption) async -> [HappyHourVideoModel]? {
        var result: [HappyHourVideoModel] = []

        guard let totalSearchPages = viewmodel.allVideos.first?.part else { return nil }
        
        switch option {
        case .byPart:
            if let partNumber = Int(query), partNumber > totalSearchPages - 8 {
                return result
            }
            result = viewmodel.allVideos.filter { String($0.part) == query }
            return result
            
        case .byDate:
            result = viewmodel.allVideos.filter { FormatHelper.formatDate($0.publishedDate) == query }
            return result
            
        case .byText:
            let searchByTextResult = viewmodel.allVideos.filter({ $0.title.lowercased().contains(query.lowercased()) })
            result.append(contentsOf: searchByTextResult)
            return result
        }
    }
    
    
    //MARK: - Network
    func fetchApiData(targetPage: Int) async throws -> [HappyHourVideoModel] {
        return try await happyHourRepository.fetchFromApiService(targetPage: targetPage).hhVideos
    }
    
    func loadNextPage(currentPage: Int) async throws -> (newPage: Int, videos: [HappyHourVideoModel]) {
        let newPage = currentPage + 8
        let videos = try await self.fetchApiData(targetPage: newPage)
        return (newPage, videos)
    }
    
    func hasMorePages(viewModel: HappyHourViewModel) -> Bool {
        guard let totalSearchPages = viewModel.allVideos.first?.part else { return false }
        return viewModel.currentPage < totalSearchPages
    }
}
