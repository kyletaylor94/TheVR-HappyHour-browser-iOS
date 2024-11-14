//
//  HomeView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HappyHourViewModel
    @State private var isSeachingActive = false
    @StateObject var spotifyVM = SpotifyViewModel()
    
    init(viewModel: HappyHourViewModel) {
        self.viewModel = HappyHourViewModel()
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundPicture()
                    .opacity(isSeachingActive ? 0.7 : 1)
                    .accessibilityIdentifier("backgroundPicture")

                
                EpisodeView(isSeachingActive: $isSeachingActive, episodes: viewModel.allVideos, viewModel: viewModel, spotifyVM: spotifyVM)
                    .opacity(isSeachingActive ? 0.3 : 1)
                    .disabled(isSeachingActive || viewModel.apiIsLoading || viewModel.dbIsLoading)

                
                SearchView(isSearcinhgActive: $isSeachingActive, viewModel: viewModel,spotifyVM: spotifyVM)
                    .opacity(isSeachingActive ? 1 : 0)
                    .accessibilityIdentifier("searchButton")

            }
            .alert(isPresented: $viewModel.hasApiError, content: {
                createApiAlert(title: "Error!", message: viewModel.apiErrorType?.errorDescription ?? "Unknown error!", primaryButtonString: "Retry") {
                    Task { await viewModel.loadPage(targetPage: viewModel.currentPage) }
                }
            })
            .alert(isPresented: $viewModel.hasDBError, content: {
                createApiAlert(title: "Error!", message: viewModel.dbErrorType?.description ?? "Unknown error!", primaryButtonString: "Retry") {
                    Task { try await viewModel.syncEpisodes() }
                }
            })
        }
        .onAppear{
            Task {
                await viewModel.loadPage(targetPage: viewModel.currentPage)
                try await viewModel.syncEpisodes()
                await spotifyVM.spotifyAuthentication()
                try await Task.sleep(nanoseconds: 500_000_000)
                await spotifyVM.fetchSpotifyEpisodes(viewModel: viewModel)
                await spotifyVM.updateSpotifyUrls(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HappyHourViewModel())
}

extension HomeView {
    private func createApiAlert(title: String, message: String, primaryButtonString: String, task: @escaping () -> Void) -> Alert {
        return Alert(title: Text(title), message: Text(message), primaryButton: .default(Text(primaryButtonString), action: {
            task()
        }), secondaryButton: .cancel())
    }
}
