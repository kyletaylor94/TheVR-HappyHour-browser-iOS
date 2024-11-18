//
//  Constants.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 07..
//

import Foundation
import SwiftUI

struct Constants {
    
    struct Urls {
        static let spotifyUrl: String = "https://open.spotify.com/show/2TViVtEtC5NjM1xEwkXK0c"
        static let youtubeBaseUrl: String = "https://youtube.com/watch?v="
    }
    
    struct Icons {
        static let youtube = "play.circle.fill"
        static let calendar = "calendar"
        static let spotify = "headphones"
        static let back = "arrow.left.circle.fill"
        static let bookmark = "bookmark.fill"
        static let coffee = "cup.and.saucer"
        static let noResultSearch = "exclamationmark.magnifyingglass"
        static let search = "magnifyingglass"
        static let xMark = "xmark"
        static let chevronUp = "chevron.up"
        static let chevronDown = "chevron.down"
    }
    
    struct CornerRadius {
        static let twenty: CGFloat = 20
        static let twelve : CGFloat = 12
        static let ten : CGFloat = 10
        static let eight : CGFloat = 8
        static let four : CGFloat = 4
    }
    
    static let rectangleWidth: CGFloat = UIScreen.main.bounds.width - 32
    static let chapterBlackColor = Color(.black).opacity(0.8)
    
    //MARK: - SpotifyID
    struct SpotifyConstants {
        static let showID = "2TViVtEtC5NjM1xEwkXK0c"
    }
}
