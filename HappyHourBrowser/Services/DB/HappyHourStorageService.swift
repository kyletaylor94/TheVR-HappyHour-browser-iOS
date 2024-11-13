//
//  HappyHourStorageServiceProtocol.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 30..
//

import Foundation

protocol HappyHourStorageService {
    func fetchFromCoreData(with predicate: NSPredicate) async throws -> [HappyHourVideoModel]?
    func saveHappyHourVideo(video: HappyHourVideoModel) async throws
}
