//
//  SpotifyInteractorImpl.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

@MainActor
class SpotifyInteractorImpl: @preconcurrency SpotifyInteractor {
    
    private var offset: Int = 0
    private let limit: Int = 8

    private var hasMorePages = true
    
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
    
    func resetPagination() {
        offset = 0
        hasMorePages = true
    }
    
    func fetchPaginatedEpisodes(happyHourVM: HappyHourViewModel, token: String?) async throws -> ([SpotifyEpisode], Bool) {
        guard hasMorePages else { return ( [], false ) }
        
        let newEpisodes = try await dependencyContainer.fetchSpotifyEpisodesFromService(
            for: Constants.SpotifyConstants.showID,
            offset: offset,
            limit: limit,
            accessToken: token
        )
        
        hasMorePages = happyHourVM.allVideos.count >= limit
        offset += limit
        
        return (newEpisodes, hasMorePages)
    }
    
    
    func syncEpisodes(happyHourVM: HappyHourViewModel, spotifyEpisodes: [SpotifyEpisode]) async throws -> [SpotifyEpisode] {
        var results: [SpotifyEpisode] = []

        results = spotifyEpisodes.filter({ episode in
            if let episodeNumber = FormatHelper.extractSpotifyEpisodeNumber(from: episode.name),
               let matchingVideoIndex = happyHourVM.allVideos.firstIndex(where: { $0.part == episodeNumber }) {
                self.saveSpotifyEpisodes(happyHourVM: happyHourVM, matchingVideoIndex: matchingVideoIndex, episode: episode)
                return true
            }
            return false
        })
        return results
    }
    

    func saveSpotifyEpisodes(happyHourVM: HappyHourViewModel, matchingVideoIndex: Int ,episode: SpotifyEpisode) {
        happyHourVM.allVideos[matchingVideoIndex].spotifyUrl = episode.external_urls
    }
    
}


