//
//  Constants.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 07..
//

import Foundation
import SwiftUI

struct Constants {
    static let shared = Constants()
    
    let spotifyUrl: String = "https://open.spotify.com/show/2TViVtEtC5NjM1xEwkXK0c"
    let youtubeBaseUrl: String = "https://youtube.com/watch?v="

    
    let youtubeIcon = "play.circle.fill"
    let calendarIcon = "calendar"
    let spotifyIcon = "headphones"
    let backButtonIcon = "arrow.left.circle.fill"
    let bookmarkIcon = "bookmark.fill"
    let coffeIcon = "cup.and.saucer"
    let noResultSearchIcon = "exclamationmark.magnifyingglass"
    let searchIcon = "magnifyingglass"
    let xMarkIcon = "xmark"
    
    let chevronUpIcon = "chevron.up"
    let chevronDownIcon = "chevron.down"
    
    let rectangleWidth: CGFloat = UIScreen.main.bounds.width - 32
    
    
}
