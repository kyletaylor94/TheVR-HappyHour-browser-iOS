//
//  DBError.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 13..
//

enum DBError: Error {
    case cannotLoadDatabase
    case cannotFetchData
    case failedToSaveData
    case cannotSyncEpisodes
    
    var description: String {
        switch self {
        case .cannotLoadDatabase:
            return "Cannot open database"
        case .cannotFetchData:
            return "Cannot fetch data"
        case .failedToSaveData:
            return "Failed to save data"
        case .cannotSyncEpisodes:
            return "Cannot Sync Episodes"
        }
    }
}
