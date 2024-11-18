//
//  EpisodeScrollView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct EpisodeScrollView: View {
    @ObservedObject var viewModel: HappyHourViewModel
    @ObservedObject var spotifyVM: SpotifyViewModel
    let episodes: [HappyHourVideoModel]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack{
                ForEach(episodes, id: \.title) { episode in
                    NavigationLink {
                        ChapterView(episode: episode, isLoading: $viewModel.apiIsLoading)
                    } label: {
                        EpisodeCell(episode: episode, isLoading: $viewModel.apiIsLoading)
                    }
                    .onAppear{
                        Task {
                            if episode == episodes.last {
                                await viewModel.loadNextPage()
                                await spotifyVM.fetchSpotifyEpisodes(viewModel: viewModel)
                                await spotifyVM.updateSpotifyUrls(viewModel: viewModel)
                            }
                            
                            try await viewModel.saveVideo(video: episode)
                        }
                    }
                }
            }
        }
        .padding(.top, 30)
    }
}
