//
//  SpotifyModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 27..
//

struct SpotifyTokenResponse: Codable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}

struct SpotifyEpisodesResponse: Codable {
    let items: [SpotifyEpisode]
}

struct SpotifyEpisode: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let description: String
    let external_urls: ExternalURL
    
    struct ExternalURL: Codable, Equatable {
        let spotify: String
    }
    
}
