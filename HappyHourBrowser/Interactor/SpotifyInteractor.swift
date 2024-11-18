//
//  SpotifyInteractor.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

protocol SpotifyInteractor {
    func fetchSpotifyTokenFromRepo() async throws -> String?

    func resetPagination()
    func fetchPaginatedEpisodes(happyHourVM: HappyHourViewModel, token: String?) async throws -> ([SpotifyEpisode], Bool)

    
    func syncEpisodes(happyHourVM: HappyHourViewModel, spotifyEpisodes: [SpotifyEpisode]) async throws -> [SpotifyEpisode]
    func saveSpotifyEpisodes(happyHourVM: HappyHourViewModel, matchingVideoIndex: Int ,episode: SpotifyEpisode)
}



