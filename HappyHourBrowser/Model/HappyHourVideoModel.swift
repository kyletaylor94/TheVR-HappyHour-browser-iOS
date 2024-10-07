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
    
    init(entity: HappyHourEntity) {
        self.id = Int(entity.id)
        self.part = Int(entity.part)
        self.title = entity.title ?? ""
        self.videoId = entity.videoId ?? ""
        self.videoCoverImg = entity.videoCoverImg ?? ""
        self.timeStampText = entity.timeStampText ?? ""
        self.publishedDate = entity.publishedDate ?? ""
    }
}
