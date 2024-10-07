//
//  ChapterView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct ChapterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var chaptersTapped: Bool = false
    
    let episode: HappyHourVideoModel
    
    private let spotifyUrl: String = "https://open.spotify.com/show/2TViVtEtC5NjM1xEwkXK0c"
    private let youtubeBaseUrl: String = "https://youtube.com/watch?v="
    
    private let youtubeIndexWidth: CGFloat = UIScreen.main.bounds.width - 40
    private let youtubeIndexHeight: CGFloat = 270
    
    private let chapterInfoWidth: CGFloat = UIScreen.main.bounds.width - 32
    private let chapterInfoHeight: CGFloat = 90

    
    var formattedTimeStamp: [String] {
        return episode.timeStampText.components(separatedBy: "\n")
    }
    
        
    var body: some View {
        ZStack {
            BackgroundPicture()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
            
            //Youtube indexpicture
                    MediaContentView(isChapturePicture: true, width: youtubeIndexWidth, height: youtubeIndexHeight, episode: episode)

            //Chapter Info
                    MediaContentView(isChapturePicture: false, width: chapterInfoWidth, height: chapterInfoHeight, episode: episode)

                    
            //Youtube Button
                    CustomMediaButton(url: youtubeBaseUrl + episode.videoId, iconName: "play.circle.fill", titleName: "Start on Youtube")
                    
            // Spotify Button
                    CustomMediaButton(url: spotifyUrl, iconName: "headphones", titleName: "Find on Spotify")
                    
                    
            // Chapters Details
                    ChapterDetailsView(chaptersTapped: $chaptersTapped, count: formattedTimeStamp.count, formattedTimeStamp: formattedTimeStamp, videoId: episode.videoId)
                }
            }
            .padding(.top, 70)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}


