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
        RoundedRectangle(cornerRadius: 12)
            .fill(.cellBG)
            .stroke(Color(.searchButtonBackGround), style: StrokeStyle())
            .frame(width: width, height: height)
            .overlay {
                if isChapturePicture {
                    if let episode = episode {
                        AsyncImage(url: URL(string: FormatHelper.youtubeThumbnailUrl(videoId: episode.videoId)), scale: 1.0) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .frame(width: width ,height: 269.9)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 15) {
                        if let episode = episode{
                            Text(FormatHelper.formattedTitle(episode.title))
                                .lineLimit(3)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black.opacity(0.8))
                        }
                        
                        HStack {
                            if let episode = episode {
                                Text("#\(String(episode.part))")
                                    .font(.title2)
                                    .fontWeight(.light)
                                    .foregroundStyle(.black.opacity(0.8))
                            }
                            
                            Spacer()
                            
                            Image(systemName: "calendar")
                                .font(.subheadline)
                                .foregroundStyle(.black.opacity(0.8))
                            
                            if let episode = episode {
                                Text(FormatHelper.formatDate(episode.publishedDate))
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .foregroundStyle(.black.opacity(0.8))
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
    }
}
