//
//  EpisodeCell.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import Shimmer

struct EpisodeCell: View {
    
    let episode: HappyHourVideoModel
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(spacing: 20){
                EpisodeIconView(part: episode.part, isLoading: $isLoading)
                
                EpisodeDetailsView(episode: episode)
                    .shimmering(active: isLoading ? true : false)

                Spacer()
            }
            .padding(.horizontal, 12)
            .frame(width: Constants.shared.rectangleWidth, height: 82)
            .background(
                RoundedRectangle(cornerRadius: Constants.shared.cornerRadiusTwenty)
                    .foregroundStyle(.cellBG)
                    .opacity(0.7)
            )
        }
    }
}
