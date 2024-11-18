//
//  SpotifyApiService.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 18..
//

protocol SpotifyApiService {
    func spotifyAuthentication() async throws -> SpotifyTokenResponse?
    func fetchSpotifyEpisodes(for showID: String, offset: Int, limit: Int, accessToken: String?) async throws -> [SpotifyEpisode]
}
