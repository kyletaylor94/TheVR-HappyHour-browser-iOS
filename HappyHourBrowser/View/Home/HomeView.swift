//
//  HomeView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import CoreData

struct HomeView: View {
    @ObservedObject var viewModel: HappyHourViewModel
    @State private var isSeachingActive = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundPicture()
                    .opacity(isSeachingActive ? 0.7 : 1)
                
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        EpisodeView(isSeachingActive: $isSeachingActive, episodes: viewModel.allVideos, viewModel: viewModel)
                            .opacity(isSeachingActive ? 0.3 : 1)
                            .disabled(isSeachingActive)
                        
                }
                
                SearchView(isSearcinhgActive: $isSeachingActive, viewModel: viewModel)
                    .opacity(isSeachingActive ? 1 : 0)
            }
            .alert(isPresented: $viewModel.hasError, content: {
                Alert(title: Text("Error!"), message: Text(viewModel.apiErrorType?.errorDescription ?? "Unknown error!"), primaryButton: .default(Text("Retry"), action: {
                    Task {
                        await viewModel.loadPage(targetPage: viewModel.currentPage)
                    }
                }), secondaryButton: .cancel())
            })
        }
        .onAppear{
            Task {
                await viewModel.syncEpisodesWithCoreData()
                await viewModel.loadPage(targetPage: viewModel.currentPage)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HappyHourViewModel(context: CoreDataHelper.shared.persistentContainer.viewContext))
        
}
