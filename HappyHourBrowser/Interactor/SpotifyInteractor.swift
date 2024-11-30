//
//  SpotifyInteractor.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

protocol SpotifyInteractor {
    func fetchSpotifyTokenFromRepo() async throws -> String?
    func fetchSearchedSpotifyEpisodes(query: String, token: String?) async throws -> SpotifyEpisode?
}


@MainActor
class SpotifyInteractorImpl: @preconcurrency SpotifyInteractor {
    
    private let type = "episode"
    private let limit = 1
    private let offset = 0
    
    private var repositoryContainer: SpotifyRepository {
        guard let container = DependencyContainer.shared.container.resolve(SpotifyRepository.self) else {
            preconditionFailure("DEBUG: Cannot resolve: \(SpotifyRepository.self)")
        }
        return container
    }
    
    func fetchSpotifyTokenFromRepo() async throws -> String? {
        let response = try await repositoryContainer.fetchSpotifyTokenFromApiService()
        guard let response else { return nil }
        return response.access_token
    }
    

    func fetchSearchedSpotifyEpisodes(query: String, token: String?) async throws -> SpotifyEpisode? {
        let results = try await repositoryContainer.fetchSearchEpisodesFromApiService(query: query, type: type, offset: offset, limit: limit, accessToken: token)
        
        return results.episodes.items.first
    }
}

