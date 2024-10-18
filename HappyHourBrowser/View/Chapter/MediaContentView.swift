//
//  MediaContentView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import Shimmer

struct MediaContentView: View {
    let isChapturePicture: Bool
    let width: CGFloat
    let height: CGFloat
    
    var episode: HappyHourVideoModel?
    @Binding var isLoading: Bool
    
    var body: some View {
        if isChapturePicture {
            if let episode = episode {
                VStack{
                    AsyncImage(url: URL(string: FormatHelper.youtubeThumbnailUrl(videoId: episode.videoId)), scale: 1.0) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width ,height: height)
                            .clipShape(RoundedRectangle(cornerRadius: Constants.CornerRadius.twelve))
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                .redacted(reason: isLoading ?  .placeholder : .invalidated)
                .shimmering(active: isLoading ? true : false)
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.CornerRadius.twelve)
                        .stroke(Color(.searchButtonBackGround),style: StrokeStyle())
                        .frame(width: width, height: height)
                }
            }
            
        } else {
            RoundedRectangle(cornerRadius: Constants.CornerRadius.twelve)
                .fill(.cellBG)
                .stroke(Color(.searchButtonBackGround), style: StrokeStyle())
                .frame(width: width, height: height)
                .overlay {
                    VStack(alignment: .leading, spacing: 15) {
                        if let episode = episode{
                            Text(FormatHelper.formattedTitle(episode.title))
                                .lineLimit(3)
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        
                        HStack {
                            if let episode = episode {
                                Text("#\(String(episode.part))")
                                    .font(.title2)
                                    .fontWeight(.light)
                            }
                            
                            Spacer()
                            
                            Image(systemName: Constants.Icons.calendar)
                                .font(.subheadline)
                            
                            if let episode = episode {
                                Text(FormatHelper.formatDate(episode.publishedDate))
                                    .font(.subheadline)
                                    .fontWeight(.light)
                            }
                        }
                    }
                    .redacted(reason: isLoading ?  .placeholder : .invalidated)
                    .shimmering(active: isLoading ? true : false)
                    .foregroundStyle(Constants.chapterBlackColor)
                    .padding(.horizontal, 8)
                }
        }
    }
}
