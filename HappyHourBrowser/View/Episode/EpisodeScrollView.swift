//
//  EpisodeScrollView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct EpisodeScrollView: View {
    @ObservedObject var happyHourVM: HappyHourViewModel
    @ObservedObject var spotifyVM: SpotifyViewModel
    let episodes: [HappyHourVideoModel]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack{
                ForEach(episodes, id: \.title) { episode in
                    NavigationLink {
                        ChapterView(episode: episode, isLoading: $happyHourVM.apiIsLoading, spotifyVM: spotifyVM)
                    } label: {
                        EpisodeCell(episode: episode, isLoading: $happyHourVM.apiIsLoading)
                    }
                    .onAppear{
                        Task {
                            if episode == episodes.last {
                                await happyHourVM.loadNextPage()
                               // await spotifyVM.updateSpotifyUrls(viewModel: viewModel)
                            }
                            
                            try await happyHourVM.saveVideo(video: episode)
                        }
                    }
                }
            }
        }
        .padding(.top, 30)
    }
}
