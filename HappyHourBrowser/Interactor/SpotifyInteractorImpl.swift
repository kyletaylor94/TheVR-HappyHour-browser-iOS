//
//  SpotifyInteractorImpl.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

@MainActor
class SpotifyInteractorImpl: SpotifyInteractor {
    
    private var dependencyContainer: SpotifyRepository {
        guard let container = DependencyContainer.shared.container.resolve(SpotifyRepository.self) else {
            preconditionFailure("DEBUG: Cannot resolve: \(SpotifyRepository.self)")
        }
        return container
    }
    
    func fetchSpotifyTokenFromRepo() async throws -> String? {
        let response = try await dependencyContainer.fetchSpotifyTokenFromService()
        guard let response else { return nil }
        return response.access_token
    }
    
    func fetchSpotifyEpisodesFromRepo(offset: Int, limit: Int, spotifyToken: String) async throws -> [SpotifyEpisode] {
        let showID = "2TViVtEtC5NjM1xEwkXK0c"
       // let spotifyToken = try await fetchSpotifyTokenFromRepo()
        
        return try await dependencyContainer.fetchSpotifyEpisodesFromService(for: showID, offset: offset, limit: limit, accessToken: spotifyToken)
    }
}
