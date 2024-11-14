//
//  SpotifyInteractor.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

protocol SpotifyInteractor {
    func fetchSpotifyTokenFromRepo() async throws -> String?
  //  func fetchSpotifyEpisodesFromRepo(offset: Int, limit: Int) async throws -> [SpotifyEpisode]
    func fetchSpotifyEpisodesFromRepo(offset: Int, limit: Int, spotifyToken: String) async throws -> [SpotifyEpisode]
}
