//
//  HappyHourMapper.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 01..
//

import Foundation

class HappyHourMapper {
    static func mapToDomainModel(entity: HappyHourEntity) -> HappyHourVideoModel {
        return HappyHourVideoModel(
            id: Int(entity.id),
            part: Int(entity.part),
            title: entity.title ?? "",
            videoId: entity.videoId ?? "",
            videoCoverImg: entity.videoCoverImg ?? "",
            timeStampText: entity.timeStampText ?? "",
            publishedDate: entity.publishedDate ?? "",
            spotifyUrl: entity.spotifyUrl.map { SpotifyEpisode.ExternalURL(spotify: $0) }
        )
    }
    
    static func mapToEntity(model: HappyHourVideoModel, entity: HappyHourEntity) {
        entity.id = Int64(model.id)
        entity.part = Int64(model.part)
        entity.title = model.title
        entity.videoId = model.videoId
        entity.videoCoverImg = model.videoCoverImg
        entity.timeStampText = model.timeStampText
        entity.publishedDate = model.publishedDate
        entity.spotifyUrl = model.spotifyUrl?.spotify
    }
}
