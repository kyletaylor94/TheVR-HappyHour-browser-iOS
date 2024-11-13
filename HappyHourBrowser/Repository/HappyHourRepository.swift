//
//  HappyHourRepositoryProtocol.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 30..
//

import Foundation

protocol HappyHourRepository {
    func fetchFromCoreData(query: String, option: SearchOption) async throws -> [HappyHourVideoModel]?
    func saveToCoreData(video: HappyHourVideoModel) async throws
    func syncEpisodesWithCoreData(allvideos: [HappyHourVideoModel]) async throws
    
    func fetchFromApiService(targetPage: Int) async throws -> HappyHourPageModel
}
