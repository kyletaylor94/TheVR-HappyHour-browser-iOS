//
//  HomeView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct HomeView: View {
    @AppStorage("disclaimer") var disclaimer: Bool = false
    @State private var showDisclaimerAlert: Bool = false
    
    @ObservedObject var happyHourVM: HappyHourViewModel
    @State private var isSeachingActive = false
    @StateObject var spotifyVM = SpotifyViewModel()
        
    init(happyHourVM: HappyHourViewModel) {
        self.happyHourVM = HappyHourViewModel()
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundPicture()
                    .opacity(isSeachingActive ? 0.7 : 1)
                    .accessibilityIdentifier("backgroundPicture")
                
                
                EpisodeView(isSeachingActive: $isSeachingActive, happyHourVM: happyHourVM, spotifyVM: spotifyVM)
                    .opacity(isSeachingActive ? 0.3 : 1)
                    .disabled(isSeachingActive || happyHourVM.apiIsLoading || happyHourVM.dbIsLoading)
                
                
                SearchView(isSearcinhgActive: $isSeachingActive, happyHourVM: happyHourVM,spotifyVM: spotifyVM)
                    .opacity(isSeachingActive ? 1 : 0)
                    .accessibilityIdentifier("searchButton")
                
            }
            .alert(isPresented: $happyHourVM.hasApiError, content: {
                createApiAlert(title: "Error!", message: happyHourVM.apiErrorType?.errorDescription ?? "Unknown error!", primaryButtonString: "Retry") {
                    Task { await happyHourVM.loadPage(targetPage: happyHourVM.currentPage) }
                }
            })
            .alert(isPresented: $happyHourVM.hasDBError, content: {
                createApiAlert(title: "Error!", message: happyHourVM.dbErrorType?.description ?? "Unknown error!", primaryButtonString: "Retry") {
                    Task { try await happyHourVM.syncEpisodes() }
                }
            })
            .alert(isPresented: $showDisclaimerAlert) {
                createDisclamerAlert()
            }
        }
        .onAppear{
            Task {
                if !disclaimer {
                    showDisclaimerAlert = true
                    await initializeAppData()
                } else {
                    await initializeAppData()
                }
            }
        }
    }
    
    private func initializeAppData() async {
        Task {
            await spotifyVM.spotifyAuthentication()
            await happyHourVM.loadPage(targetPage: happyHourVM.currentPage)
            try await happyHourVM.syncEpisodes()
           // await spotifyVM.updateSpotifyUrls(viewModel: viewModel)
        }
    }
}

#Preview {
    HomeView(happyHourVM: HappyHourViewModel())
}

extension HomeView {
    private func createApiAlert(title: String, message: String, primaryButtonString: String, task: @escaping () -> Void) -> Alert {
        return Alert(title: Text(title), message: Text(message), primaryButton: .default(Text(primaryButtonString), action: {
            task()
        }), secondaryButton: .cancel())
    }
    
    private  func createDisclamerAlert() -> Alert {
        return Alert(
            title: Text("Disclaimer"),
            message: Text("This is a hobby project from fans and not officially related to TheVR."),
            dismissButton: .default(Text("Acknowledged")) {
                disclaimer = true
            }
        )
    }
}
