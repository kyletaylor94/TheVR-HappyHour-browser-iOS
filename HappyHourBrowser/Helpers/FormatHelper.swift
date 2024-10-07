//
//  FormatHelper.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import Foundation

class FormatHelper {
    
    static func formattedTitle(_ fullTitle: String) -> String {
        let splitTitle = fullTitle.components(separatedBy: " | ")
        return splitTitle.first ?? ""
    }
    
    static func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    static func convertToSeconds(from timestamp: String) -> Int {
        let components = timestamp.split(separator: ":").map { Int($0) ?? 0 }
        if components.count == 3 {
            let hours = components[0]
            let minutes = components[1]
            let seconds = components[2]
            return (hours * 3600) + (minutes * 60) + seconds
        } else if components.count == 2 {
            let minutes = components[0]
            let seconds = components[1]
            return (minutes * 60) + seconds
        } else {
            return 0
        }
    }
    
    static func youtubeChapterUrl(for timestampString: String, for videoId: String) -> String {
        let seconds = convertToSeconds(from: timestampString)
        return "https://www.youtube.com/watch?v=\(videoId)&t=\(seconds)s"
    }
    
    static func extractTimeStamp(from chapter: String) -> String {
        // Válasszuk el a stringet az első "-" karakter alapján
        let components = chapter.components(separatedBy: " - ")
        if let timeStamp = components.first {
            // Töröljük az esetleges felesleges whitespace és kocsi visszatérítést
            return timeStamp.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return "00:00:00"
    }
    
    static func youtubeThumbnailUrl(videoId: String) -> String {
        let thumbnailEndpointTemplate = "https://img.youtube.com/vi/%s/0.jpg"
        let thumbnailUrl = thumbnailEndpointTemplate.replacingOccurrences(of: "%s", with: videoId)
        return thumbnailUrl
    }
}
