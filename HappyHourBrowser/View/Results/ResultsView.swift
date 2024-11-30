//
//  ResultsView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI


struct ResultsView: View {
    @ObservedObject var happyHourVM: HappyHourViewModel
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
                
            
                .padding(.top)
                Spacer()
                
                if isLoading {
                    CustomProgressView()
                    Spacer()
                    
                } else if !happyHourVM.searchVideos.isEmpty {
                    EpisodeScrollView(happyHourVM: happyHourVM, spotifyVM: spotifyVM, episodes: happyHourVM.searchVideos)
                } else {
                    NoResultsView()
                    Spacer()
                }
            }
        }
        .onAppear {
            Task {
                try await happyHourVM.startSearch(viewModel: happyHourVM, query: searchedText, option: selectedOption)
                if !happyHourVM.searchVideos.isEmpty {
                    self.isLoading = false
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ResultsView(happyHourVM: HappyHourViewModel(), spotifyVM: SpotifyViewModel(), searchedText: .constant(""), selectedOption: .byText)
}

