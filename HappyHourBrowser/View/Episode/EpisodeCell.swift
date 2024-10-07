//
//  EpisodeCell.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct EpisodeCell: View {
    
    let episode: HappyHourVideoModel
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack(spacing: 20){
                EpisodeIconView(part: episode.part)
                
                EpisodeDetailsView(episode: episode)
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .frame(width: Constants.shared.rectangleWidth, height: 82)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.cellBG)
                    .opacity(0.7)
            )
        }
    }
}
