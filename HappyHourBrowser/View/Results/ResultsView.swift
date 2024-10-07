//
//  ResultsView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI


struct ResultsView: View {
    @ObservedObject var viewModel: HappyHourViewModel
    @Binding var searchedText: String
    var selectedOption: SearchOption
    
    var body: some View {
        ZStack{
            BackgroundPicture()
            
            VStack{
                ResultsTopView(searchedText: $searchedText)
                    .padding(.top, 40)
                
                Spacer()
                                
                if viewModel.isLoading {
                    
                    CustomProgressView()
                        
                    Spacer()

                } else if viewModel.searchResults.isEmpty {
                    NoResultsView()
                    Spacer()

                } else {
                    EpisodeScrollView(viewModel: viewModel, episodes: viewModel.searchResults)
                        .padding(.top, -30)
                }
            }
        }
        .onAppear{
            Task {
                switch selectedOption {
                    
                case .byPart:
                    await viewModel.searchEpisodes(option: .byPart, query: searchedText)
                case .byDate:
                    await viewModel.searchEpisodes(option: .byDate, query: searchedText)

                case .byText:
                    await viewModel.searchEpisodes(option: .byText, query: searchedText)

                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ResultsView(viewModel: HappyHourViewModel(context: CoreDataHelper.shared.persistentContainer.viewContext), searchedText: .constant(""), selectedOption: .byText)
}
