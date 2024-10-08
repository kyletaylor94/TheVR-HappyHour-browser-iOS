//
//  EpisodeScrollView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct EpisodeScrollView: View {
    @ObservedObject var viewModel: HappyHourViewModel
    
    let episodes: [HappyHourVideoModel]

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack{
                ForEach(episodes, id: \.title) { episode in
                    NavigationLink {
                        ChapterView(episode: episode, isLoading: $viewModel.isLoading)
                    } label: {
                        EpisodeCell(episode: episode, isLoading: $viewModel.isLoading)
                    }
                    .onAppear {
                        if episode == episodes.last {
                            Task { await viewModel.loadNextPage() }
                        }
                    }
                    .task {
                        await viewModel.saveHappyHourVideo(video: episode)
                    }
                }
            }
        }
        .padding(.top, 30)
    }
}
