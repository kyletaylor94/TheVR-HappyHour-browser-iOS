//
//  HappyHourApiServiceProtocol.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 30..
//

import Foundation

protocol HappyHourApiService {
    func getLoadHappyHourPage(targetPage: Int) async throws -> HappyHourPageModel
    func spotifyAuthentication() async throws -> SpotifyTokenResponse?
    func fetchSpotifyEpisodes(for showID: String, offset: Int, limit: Int, accessToken: String?) async throws -> [SpotifyEpisode]
}
