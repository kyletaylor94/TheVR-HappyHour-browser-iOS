//
//  EpisodeIconView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import Shimmer

struct EpisodeIconView: View {
    let part: Int
    @Binding var isLoading: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Image(systemName: Constants.shared.coffeIcon)
                .shimmering(active: isLoading ? true : false)

            Text(String(part))
                .shimmering(active: isLoading ? true : false)

        }
        .foregroundStyle(.tabBar)
        .frame(width: 50, height: 60)
        .background(
            RoundedRectangle(cornerRadius: Constants.shared.cornerRadiusEight)
                .fill(.white.opacity(0.4))
                .stroke(.searchButtonBackGround)
        )
    }
}
