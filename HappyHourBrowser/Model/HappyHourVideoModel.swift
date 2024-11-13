//
//  HappyHourVideoModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import Foundation

struct HappyHourVideoModel: Codable, Identifiable, Equatable {
    let id: Int
    let part: Int
    let title: String
    let videoId: String
    let videoCoverImg: String?
    let timeStampText: String
    let publishedDate: String
    var spotifyUrl: SpotifyEpisode.ExternalURL?
}
