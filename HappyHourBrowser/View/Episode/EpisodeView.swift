//
//  EpisodeView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct EpisodeView: View {
    @Binding var isSeachingActive: Bool
    let episodes: [HappyHourVideoModel]
    @ObservedObject var viewModel: HappyHourViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            EpisodeScrollView(viewModel: viewModel, episodes: episodes)
                .padding(.top, 30)
            
            CustomSearchButton(isSearchingActive: $isSeachingActive)
                .padding(.trailing, 40)
                .padding(.bottom, 50)
        }
    }
}
