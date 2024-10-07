//
//  EpisodeIconView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct EpisodeIconView: View {
    let part: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Image(systemName: Constants.shared.coffeIcon)
            
            Text(String(part))
        }
        .foregroundStyle(.tabBar)
        .frame(width: 50, height: 60)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.white.opacity(0.4))
                .stroke(.searchButtonBackGround)
        )
    }
}
