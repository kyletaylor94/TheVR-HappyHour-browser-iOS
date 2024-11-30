//
//  SpotifyViewModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 26..
//

import Foundation

@MainActor
class SpotifyViewModel: ObservableObject {
    
    @Published var spotifyEpisode: SpotifyEpisode? = nil
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
    
    func searchResults(query: String) async {
        guard let token = spotifyToken else { return }
        
        do {
            self.spotifyEpisode = try await interactor.fetchSearchedSpotifyEpisodes(query: query, token: token)
        } catch {
            print("DEBUG: Cannot fetch search results: \(error.localizedDescription)")
        }
    }
}
