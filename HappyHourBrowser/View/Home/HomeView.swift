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
    
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundPicture()
                    .opacity(isSeachingActive ? 0.7 : 1)
                
                    if viewModel.isLoading {
                        CustomProgressView()
                    } else {
                        EpisodeView(isSeachingActive: $isSeachingActive, episodes: viewModel.allVideos, viewModel: viewModel)
                            .opacity(isSeachingActive ? 0.3 : 1)
                            .disabled(isSeachingActive)
                }
                
                SearchView(isSearcinhgActive: $isSeachingActive, viewModel: viewModel)
                    .opacity(isSeachingActive ? 1 : 0)
            }
            .alert(isPresented: $viewModel.hasError, content: {
                createApiAlert(title: "Error!", message: viewModel.apiErrorType?.errorDescription ?? "Unknown error!", primaryButtonString: "Retry") {
                    Task { await viewModel.loadPage(targetPage: viewModel.currentPage) }
                }
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

extension HomeView {
    private func createApiAlert(title: String, message: String, primaryButtonString: String, task: @escaping () -> Void) -> Alert {
        return Alert(title: Text(title), message: Text(message), primaryButton: .default(Text(primaryButtonString), action: {
                 task()
        }), secondaryButton: .cancel())
    }
}
