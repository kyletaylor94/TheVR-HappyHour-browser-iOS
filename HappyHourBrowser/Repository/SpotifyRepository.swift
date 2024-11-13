//
//  SpotifyRepository.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

protocol SpotifyRepository {
    func fetchSpotifyTokenFromService() async throws -> SpotifyTokenResponse?
    func fetchSpotifyEpisodesFromService(for showID: String, offset: Int, limit: Int, accessToken: String?) async throws -> [SpotifyEpisode]
}
