//
//  MediaContentView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct MediaContentView: View {
    let isChapturePicture: Bool
    let width: CGFloat
    let height: CGFloat
    
    var episode: HappyHourVideoModel?
    
    var body: some View {
        if isChapturePicture {
            if let episode = episode {
                VStack{
                    AsyncImage(url: URL(string: FormatHelper.youtubeThumbnailUrl(videoId: episode.videoId)), scale: 1.0) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width ,height: height)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(.searchButtonBackGround),style: StrokeStyle())
                        .frame(width: width, height: height)
                }
            }
        } else {
            RoundedRectangle(cornerRadius: 12)
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
                            
                            Image(systemName: Constants.shared.calendarIcon)
                                .font(.subheadline)
                            
                            if let episode = episode {
                                Text(FormatHelper.formatDate(episode.publishedDate))
                                    .font(.subheadline)
                                    .fontWeight(.light)
                            }
                        }
                    }
                    .foregroundStyle(.black.opacity(0.8))
                    .padding(.horizontal, 8)
                }
        }
    }
}
