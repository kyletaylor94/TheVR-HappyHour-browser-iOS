//
//  ChapterView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import Shimmer

struct ChapterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var chaptersTapped: Bool = false
    
    let episode: HappyHourVideoModel
        
    private let youtubeIndexWidth: CGFloat = UIScreen.main.bounds.width - 40
    private let youtubeIndexHeight: CGFloat = 270
    
    private let chapterInfoHeight: CGFloat = 90
    
    
    var formattedTimeStamp: [String] {
        return episode.timeStampText.components(separatedBy: "\n")
    }
    
    var formattedSpotifyLink: String?  {
        return episode.spotifyUrl?.spotify ?? ""
    }
    
    @Binding var isLoading: Bool
        
    var body: some View {
        ZStack {
            BackgroundPicture()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
            
            //Youtube indexpicture
                    MediaContentView(
                        isChapturePicture: true,
                        width: youtubeIndexWidth,
                        height: youtubeIndexHeight,
                        episode: episode,
                        isLoading: $isLoading
                    )

            //Chapter Info
                    MediaContentView(
                        isChapturePicture: false,
                        width: Constants.rectangleWidth,
                        height: chapterInfoHeight,
                        episode: episode,
                        isLoading: $isLoading
                    )
                      
                    
            //Youtube Button
                    CustomMediaButton(
                        url: Constants.Urls.youtubeBaseUrl + episode.videoId,
                        iconName: Constants.Icons.youtube,
                        titleName: "Start on Youtube",
                        width: Constants.rectangleWidth,
                        isLoading: $isLoading
                    )
                       
                    
            // Spotify Button
                    CustomMediaButton(
                        url: formattedSpotifyLink ?? "",
                        iconName: Constants.Icons.spotify,
                        titleName: "Find on Spotify",
                        width: Constants.rectangleWidth,
                        isLoading: $isLoading
                    )
                      
                    
            // Chapters Details
                    ChapterDetailsView(
                        chaptersTapped: $chaptersTapped,
                        isLoading: $isLoading,
                        count: formattedTimeStamp.count,
                        formattedTimeStamp: formattedTimeStamp,
                        videoId: episode.videoId
                    )
                }
            }
            .padding(.top, 70)
            .padding(.bottom, 120)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: Constants.Icons.back)
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}


