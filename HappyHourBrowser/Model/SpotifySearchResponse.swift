//
//  SpotifySearchResponse.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 18..
//

import Foundation

struct SpotifySearchResponse: Codable {
    let episodes: SpotifyEpisodesContainer
}

struct SpotifyEpisodesContainer: Codable {
    let href: String
    let items: [SpotifyEpisode]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}
