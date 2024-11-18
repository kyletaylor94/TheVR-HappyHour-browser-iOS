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

@MainActor
class HappyHourViewModel: ObservableObject {
    
    @Published var dbErrorType: DBError?
    @Published var apiErrorType: ApiError?
    @Published var hasApiError: Bool = false
    @Published var hasDBError: Bool = false

    @Published var apiIsLoading = true
    @Published var dbIsLoading = true

    @Published var currentPage: Int = -8
    
    @Published var allVideos: [HappyHourVideoModel] = []
    @Published var searchVideos: [HappyHourVideoModel] = []
    
    
    private var interactor: HappyHourInteractor {
        guard let resolvedInteractor = DependencyContainer.shared.container.resolve(HappyHourInteractor.self) else {
            preconditionFailure("Failed to resolve \(HappyHourInteractor.self)")
        }
        return resolvedInteractor
    }
    
    
    //MARK: - Networking
    func loadPage(targetPage: Int) async {
        do {
            self.allVideos.append(contentsOf: try await interactor.fetchApiData(targetPage: targetPage) )
            self.apiIsLoading = false
            print(self.allVideos.count)
        } catch {
            self.apiIsLoading = false
            self.apiErrorType = error as? ApiError
            self.hasApiError = true
            print(String(describing: error))
        }
    }
    
    func loadNextPage() async {
        do {
            let result = try await interactor.loadNextPage(currentPage: currentPage)
            self.currentPage = result.newPage
            self.allVideos.append(contentsOf: result.videos)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Interactor
    func startSearch(viewModel: HappyHourViewModel,query: String, option: SearchOption) async throws {
        do {
            self.searchVideos = try await interactor.searchEpisodes(viewModel: viewModel, option: option, query: query)
        } catch {
            print("DEBUG: Cannot search")
        }
    }
    
    //MARK: Repository
    func saveVideo(video: HappyHourVideoModel) async throws {
        do {
            try await interactor.saveVideoToCoreData(video: video)
            self.dbIsLoading = false
        } catch {
            self.hasDBError = true
            self.dbErrorType = .failedToSaveData
        }
    }
    
    func syncEpisodes() async throws {
        do {
            try await interactor.syncEpisodesWithCoreData(allvideos: allVideos)
            self.dbIsLoading = false
        } catch {
            self.hasDBError = true
            self.dbErrorType = .cannotSyncEpisodes
        }
    }
}

