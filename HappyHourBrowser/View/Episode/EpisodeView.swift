//
//  EpisodeView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import Shimmer

struct EpisodeView: View {
    @Binding var isSeachingActive: Bool
    var episodes: [HappyHourVideoModel]
    @ObservedObject var viewModel: HappyHourViewModel
    @ObservedObject var spotifyVM: SpotifyViewModel
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            EpisodeScrollView(viewModel: viewModel, spotifyVM: spotifyVM, episodes: episodes)
                .padding(.top, 30)
                .redacted(reason: viewModel.apiIsLoading || viewModel.dbIsLoading ?  .placeholder : .invalidated)

            CustomSearchButton(isSearchingActive: $isSeachingActive)
                .padding(.trailing, 40)
                .padding(.bottom, 50)
                .disabled(viewModel.apiIsLoading || viewModel.dbIsLoading ? true : false)
        }
    }
}
