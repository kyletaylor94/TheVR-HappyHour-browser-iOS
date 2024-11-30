//
//  HappyHourStorageServiceProtocol.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 30..
//

import Foundation
import CoreData

protocol HappyHourStorageService {
    func fetchFromCoreData(with predicate: NSPredicate) async throws -> [HappyHourVideoModel]?
    func saveHappyHourVideo(video: HappyHourVideoModel) async throws
}

class HappyHourStorageServiceImpl: HappyHourStorageService {
    
   var persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores { description, error in
            if error != nil {
                print("DEBUG: \(DBError.cannotLoadDatabase)")
            } else {
                print("DEBUG: CoreDataLoading - Core data loaded successfully")
            }
        }
    }
    
    func fetchFromCoreData(with predicate: NSPredicate)  -> [HappyHourVideoModel]? {
        let fetchRequest = NSFetchRequest<HappyHourEntity>(entityName: "HappyHourEntity")
        fetchRequest.predicate = predicate
        
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            return results.map { HappyHourMapper.mapToDomainModel(entity: $0) }
        } catch {
            print("DEBUG: \(DBError.cannotFetchData)")
            return nil
        }
    }
    
    func saveHappyHourVideo(video: HappyHourVideoModel)  {
        persistentContainer.viewContext.performAndWait {
            let fetchRequest = NSFetchRequest<HappyHourEntity>(entityName: "HappyHourEntity")
            fetchRequest.predicate = NSPredicate(format: "id == %d", video.id)
            do {
                let results = try persistentContainer.viewContext.fetch(fetchRequest)
                if results.isEmpty {
                    let happyHourEntity = HappyHourEntity(context: persistentContainer.viewContext)
                    HappyHourMapper.mapToEntity(model: video, entity: happyHourEntity)
                    
                    try persistentContainer.viewContext.save()
                    print("video saved successfully!")
                } else {
                    print("video already exists, skipping save")
                }
            } catch {
                print("DEBUG: \(DBError.failedToSaveData)")
            }
        }
    }
}
