//
//  HappyHourPageModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import Foundation

struct HappyHourPageModel: Codable {
    let hhVideos: [HappyHourVideoModel]
    let page: Int
    
    private enum CodingKeys: String, CodingKey {
        case hhVideos = "hh_videos"
        case page = "page"
    }
}
