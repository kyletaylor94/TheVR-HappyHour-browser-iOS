//
//  ChapterCell.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct ChapterCell: View {
    let chapter: String
    let timeStampString: String
    let videoId: String
        
    var body: some View {
        Link(destination: URL(string: FormatHelper.youtubeChapterUrl(for: timeStampString, for: videoId))!) {
            HStack(spacing: 30) {
                Text(chapter)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.black.opacity(0.8))
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.horizontal, 5)
            .frame(width: UIScreen.main.bounds.width - 50, height: 30)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.chapterCell)
                    .stroke(Color(.searchButtonBackGround))
            )
        }
    }
}
