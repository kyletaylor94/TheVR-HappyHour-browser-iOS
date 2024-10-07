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
        Link(destination: (URL(string: FormatHelper.youtubeChapterUrl(for: timeStampString, for: videoId)) ?? URL(string: "https://google.com/"))!) {
            HStack(spacing: 30) {
                Text(chapter)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(Constants.shared.chapterBlackColor)
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(.horizontal, 5)
            .frame(width: UIScreen.main.bounds.width - 50, height: 30)
            .background(
                RoundedRectangle(cornerRadius: Constants.shared.cornerRadiusEight)
                    .fill(.chapterCell)
                    .stroke(Color(.searchButtonBackGround))
            )
        }
    }
}
