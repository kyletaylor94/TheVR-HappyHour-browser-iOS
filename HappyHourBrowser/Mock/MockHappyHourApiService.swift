//
//  MockHappyHourApiService.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

import Foundation

class MockHappyHourApiService: HappyHourApiService {
      
    var shouldThrowError: Bool = false
    var mockSpotifyEpisode: [SpotifyEpisode] = [
        SpotifyEpisode(id: "0", name: "", description: "", external_urls: SpotifyEpisode.ExternalURL(spotify: "")),
        SpotifyEpisode(id: "1", name: "", description: "", external_urls: SpotifyEpisode.ExternalURL(spotify: "")),
        SpotifyEpisode(id: "2", name: "", description: "", external_urls: SpotifyEpisode.ExternalURL(spotify: "")),
    ]
    var mockVideos: [HappyHourVideoModel] = [
        HappyHourVideoModel(id: 0, part: 0, title: "12 millió munanélküli!", videoId: "0", videoCoverImg: "", timeStampText: "", publishedDate: "2024-11-13"),
        HappyHourVideoModel(id: 1, part: 1, title: "Lett pénz létrára 🤑", videoId: "1", videoCoverImg: "", timeStampText: "", publishedDate: "2024-11-12"),
        HappyHourVideoModel(id: 2, part: 2, title: "Mi tudjuk Az Igazat!", videoId: "2", videoCoverImg: "", timeStampText: "", publishedDate: "2024-11-11"),
    ]
    
    var mockPageModel: HappyHourPageModel {
        return HappyHourPageModel(hhVideos: self.mockVideos, page: 1)
    }

    func getLoadHappyHourPage(targetPage: Int) async throws -> HappyHourPageModel {
        if shouldThrowError {
            throw ApiError.badUrl
        }
        return mockPageModel
    }
    
    func spotifyAuthentication() async throws -> SpotifyTokenResponse? {
        return nil
    }
    
    func fetchSpotifyEpisodes(for showID: String, offset: Int, limit: Int, accessToken: String?) async throws -> [SpotifyEpisode] {
        return []
    }
    
}
