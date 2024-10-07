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
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.black.opacity(0.8))
                .fontWeight(.semibold)
            
            HStack(alignment: .top) {
                Image(systemName: "calendar")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.8))
                
                Text(FormatHelper.formatDate(episode.publishedDate))
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.8))
                    .fontWeight(.light)
            }
        }
    }
}
