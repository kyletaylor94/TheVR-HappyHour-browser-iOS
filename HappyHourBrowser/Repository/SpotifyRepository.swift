//
//  SpotifyRepository.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

protocol SpotifyRepository {
    func fetchSpotifyTokenFromApiService() async throws -> SpotifyTokenResponse?
    func fetchSearchEpisodesFromApiService(query: String, type: String, offset: Int, limit: Int, accessToken: String?) async throws -> SpotifySearchResponse
}


@MainActor
class SpotifyRepositoryImpl: @preconcurrency SpotifyRepository {
    
    private var apiService: SpotifyApiService {
        guard let container = DependencyContainer.shared.container.resolve(SpotifyApiService.self) else {
            preconditionFailure("DEBUG: Cannot resolve: \(SpotifyApiService.self)")
        }
        return container
    }
    
    
    func fetchSpotifyTokenFromApiService() async throws -> SpotifyTokenResponse? {
        return try await apiService.spotifyAuthentication()
    }
    
    
    func fetchSearchEpisodesFromApiService(query: String, type: String, offset: Int, limit: Int, accessToken: String?) async throws -> SpotifySearchResponse {
        return try await apiService.searchSpotifyEpisodes(query: query, type: type, limit: limit, offset: offset, accessToken: accessToken)
    }
}
