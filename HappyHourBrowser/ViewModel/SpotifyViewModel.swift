//
//  SpotifyViewModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 26..
//

import Foundation

@MainActor
class SpotifyViewModel: ObservableObject {
    //    private let apiService = HappyHourApiServiceImpl()
    //    @Published var episodes: [SpotifyEpisode] = []
    //    @Published var hasMorePages: Bool = true
    //
    //    private var offset: Int = 0
    //    private let limit: Int = 20
    //
    //    private let happyHourVM: HappyHourViewModel
    //
    //       init(happyHourVM: HappyHourViewModel) {
    //           self.happyHourVM = happyHourVM
    //       }
    //
    //
    //    func authenticate() async {
    //        apiService.spotifyAuthentication()
    //    }
    //
    //    func fetchEpisodes() async {
    //        offset = 0
    //        await fetchNextEpisodes()
    //    }
    //
    //    func fetchNextEpisodes() async {
    //        guard hasMorePages else { return }
    //
    //        do {
    //            let newEpisodes = try await apiService.fetchSpotifyEpisodes(for: "2TViVtEtC5NjM1xEwkXK0c", offset: offset, limit: limit)
    //
    //            if newEpisodes.isEmpty {
    //                hasMorePages = false
    //            } else {
    //                self.episodes.append(contentsOf: newEpisodes)
    //                offset += limit
    //                await happyHourVM.updateSpotifyUrls(from: newEpisodes)
    //            }
    //        } catch {
    //            print("somethging went wrong here \(error.localizedDescription)")
    //        }
    //    }
    
    @Published var episodes: [SpotifyEpisode] = []
    @Published var hasMorePages: Bool = true
    
    private var offset = 0
    private let limit: Int = 20
    
    private var interactor: SpotifyInteractor {
        guard let container = DependencyContainer.shared.container.resolve(SpotifyInteractor.self) else {
            preconditionFailure("DEBUG: Cannot resolve: \(SpotifyInteractor.self)")
        }
        return container
    }
    
    
    func fetchSpotifyEpisodes() async {
        do {
            self.episodes.append(contentsOf: try await self.interactor.fetchSpotifyEpisodesFromRepo(offset: offset, limit: limit))
        } catch {
            print("DEBUG: Cannot fetch Spotify episodes: \(error.localizedDescription)")
        }
    }
    
    //TODO: Load nextPage
    //TODO: Sync with database - write spotifyLink into the DB!
    
    
}
