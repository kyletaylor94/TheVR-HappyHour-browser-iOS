//
//  SpotifyViewModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 26..
//

//TODO: Clean code for the Spotify: Repository - Interactor - ViewModel - DONE
//TODO: After searching - insert spotify link to the db
//TODO: Bug - After install app - no data content available, if I close and reopen the app, apicall works fine. - DONE

import Foundation

@MainActor
class SpotifyViewModel: ObservableObject {
    
    @Published var episodes: [SpotifyEpisode] = []
    @Published var hasMorePages: Bool = true
    
    private var spotifyToken: String? = ""
    
    private var interactor: SpotifyInteractor {
        guard let container = DependencyContainer.shared.container.resolve(SpotifyInteractor.self) else {
            preconditionFailure("DEBUG: Cannot resolve: \(SpotifyInteractor.self)")
        }
        return container
    }
    
    func spotifyAuthentication() async {
        do {
            self.spotifyToken = try await self.interactor.fetchSpotifyTokenFromRepo()
        } catch {
            print("DEBUG: SpotifyAuthentication Failed! - \(error.localizedDescription)")
        }
    }
    
    func fetchSpotifyEpisodes(viewModel: HappyHourViewModel) async {
        guard let spotifyToken else { return }
        
        do {
            let (newEpisodes, hasMorePages) = try await interactor.fetchPaginatedEpisodes(happyHourVM: viewModel, token: spotifyToken)
            self.episodes.append(contentsOf: newEpisodes)
            self.hasMorePages = hasMorePages
        } catch {
            print("DEBUG: Cannot fetch Spotify episodes: \(error.localizedDescription)")
        }
    }
     
    func updateSpotifyUrls(viewModel: HappyHourViewModel) async {
        do {
            self.episodes = try await interactor.syncEpisodes(happyHourVM: viewModel, spotifyEpisodes: self.episodes)
        } catch {
            print("DEBUG: - Cannot sync/save spotify episodes")
        }
    }
    
    func resetPagination() {
        self.interactor.resetPagination()
        episodes = []
        hasMorePages = true
    }
}
