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
