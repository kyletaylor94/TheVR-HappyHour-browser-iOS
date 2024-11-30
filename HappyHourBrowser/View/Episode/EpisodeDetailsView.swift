//
//  EpisodeDetailsView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: HappyHourVideoModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(FormatHelper.formattedTitle(episode.title))
                .multilineTextAlignment(.leading)
                .fontWeight(.semibold)
            
            HStack(alignment: .top) {
                Image(systemName: Constants.Icons.calendar)
                
                Text(FormatHelper.formatDate(episode.publishedDate))
                    .fontWeight(.light)
            }
        }
        .font(.subheadline)
        .foregroundStyle(Constants.ChapterColor.chapterBlackColor)
    }
}
