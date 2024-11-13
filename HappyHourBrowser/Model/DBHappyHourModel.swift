//
//  DBHappyHourModel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 01..
//

import Foundation
import CoreData

@objc(HappyHourEntity)
class HappyHourEntity: NSManagedObject {
    @NSManaged var id: Int64
    @NSManaged var part: Int64
    @NSManaged var title: String?
    @NSManaged var videoId: String?
    @NSManaged var videoCoverImg: String?
    @NSManaged var timeStampText: String?
    @NSManaged var publishedDate: String?
    @NSManaged var spotifyUrl: String?
}
