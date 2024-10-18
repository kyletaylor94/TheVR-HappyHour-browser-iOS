//
//  ChapterCell.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import Shimmer

struct ChapterCell: View {
    let chapter: String
    let timeStampString: String
    let videoId: String
    
    @Binding var isLoading: Bool
    
    var body: some View {
        Link(destination: (URL(string: FormatHelper.youtubeChapterUrl(for: timeStampString, for: videoId)) ?? URL(string: "https://google.com/"))!) {
            HStack(spacing: 30) {
                Text(chapter)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(Constants.chapterBlackColor)
                    .lineLimit(1)
                
                Spacer()
            }
            .redacted(reason: isLoading ?  .placeholder : .invalidated)
            .shimmering(active: isLoading ? true : false)
            .padding(.horizontal, 5)
            .frame(width: UIScreen.main.bounds.width - 50, height: 30)
            .background(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.eight)
                    .fill(.chapterCell)
                    .stroke(Color(.searchButtonBackGround))
            )
        }
    }
}
