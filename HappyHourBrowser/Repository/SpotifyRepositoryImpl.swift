//
//  SpotifyRepositoryImpl.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

@MainActor
class SpotifyRepositoryImpl: SpotifyRepository {
    
    private var dependencyContainer: HappyHourApiService {
        guard let container = DependencyContainer.shared.container.resolve(HappyHourApiService.self) else {
            preconditionFailure("DEBUG: Cannot resolve: \(HappyHourApiService.self)")
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
