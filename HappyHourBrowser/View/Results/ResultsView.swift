//
//  ResultsView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI


struct ResultsView: View {
    @ObservedObject var viewModel: HappyHourViewModel
    @ObservedObject var spotifyVM: SpotifyViewModel
    @Binding var searchedText: String
    var selectedOption: SearchOption
    @State private var isLoading = true
    
    var body: some View {
        ZStack{
            BackgroundPicture()
            
            VStack{
                ResultsTopView(searchedText: $searchedText)
                    .padding(.top, 40)
                
                Spacer()
                                                
                if isLoading {
                    CustomProgressView()
                    Spacer()
                } else if !viewModel.searchVideos.isEmpty {
                    EpisodeScrollView(viewModel: viewModel, spotifyVM: spotifyVM, episodes: viewModel.searchVideos)
                } else {
                    NoResultsView()
                    Spacer()
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.startSearch(viewModel: viewModel, query: searchedText, option: selectedOption)
                if !viewModel.searchVideos.isEmpty {
                    self.isLoading = false
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

