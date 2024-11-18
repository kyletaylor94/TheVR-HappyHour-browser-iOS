//
//  SpotifyRepositoryImpl.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

@MainActor
class SpotifyRepositoryImpl: @preconcurrency SpotifyRepository {
    
    private var dependencyContainer: SpotifyApiService {
        guard let container = DependencyContainer.shared.container.resolve(SpotifyApiService.self) else {
            preconditionFailure("DEBUG: Cannot resolve: \(SpotifyApiService.self)")
        }
        return container
    }
    
    func fetchSpotifyTokenFromService() async throws -> SpotifyTokenResponse? {
        return try await dependencyContainer.spotifyAuthentication()
    }
    
    func fetchSpotifyEpisodesFromService(for showID: String, offset: Int, limit: Int, accessToken: String?) async throws -> [SpotifyEpisode] {
        return try await dependencyContainer.fetchSpotifyEpisodes(for: showID, offset: offset, limit: limit, accessToken: accessToken)
    }
    
  
    
}
