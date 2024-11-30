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
    @ObservedObject var happyHourVM: HappyHourViewModel
    @ObservedObject var spotifyVM: SpotifyViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            EpisodeScrollView(happyHourVM: happyHourVM, spotifyVM: spotifyVM, episodes: happyHourVM.allVideos)
                .padding(.top, 30)
                .redacted(reason: happyHourVM.apiIsLoading || happyHourVM.dbIsLoading ?  .placeholder : .invalidated)

            CustomSearchButton(isSearchingActive: $isSeachingActive)
                .padding(.trailing, 40)
                .padding(.bottom, 50)
                .disabled(happyHourVM.apiIsLoading || happyHourVM.dbIsLoading ? true : false)
        }
    }
}
