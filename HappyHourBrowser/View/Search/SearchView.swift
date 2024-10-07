//
//  SearchView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

enum SearchOption: String, CaseIterable {
    case byPart = "By Part"
    case byDate = "By Date"
    case byText = "By Text"
}

struct SearchView: View {
    @State private var selectedSearchOption: SearchOption = .byPart
    
    @State private var searchByText: String = ""
    @State private var searchByDate: String = ""
    @State private var searchByPart: String = ""
    
    
    @State private var navigateToResult: Bool = false
    @State private var textFieldIsEmpty: Bool  = true
    
    @Binding var isSearcinhgActive: Bool
    
    @ObservedObject var viewModel: HappyHourViewModel
    
    @State private var currentDate = Date.now
    
    
    var body: some View {
        VStack(alignment: .center){
            SearchTopView(isSearcinhgActive: $isSearcinhgActive)
            
            searchOptionView
            
            VStack(alignment: .center, spacing: 20){
                InputAndSearchButtonView(
                    selectedSearchOption: $selectedSearchOption,
                    textFieldIsEmpty: $textFieldIsEmpty,
                    searchByPart: $searchByPart,
                    searchByDate: $searchByDate,
                    searchByText: $searchByText,
                    currentDate: $currentDate,
                    navigateToResult: $navigateToResult,
                    viewModel: viewModel
                )
            }
            .padding(3)
        }
        .onAppear{
            resetFields()
        }
        .frame(width: UIScreen.main.bounds.width - 75, height: 480)
        .background(
            RoundedRectangle(cornerRadius: Constants.shared.cornerRadiusTwelve)
                .foregroundStyle(.backGround)
        )
    }
    
    
    @ViewBuilder
    private var searchOptionView: some View {
        VStack(alignment: .leading) {
            ForEach(SearchOption.allCases, id: \.rawValue) { option in
                searchOptionButton(for: option)
            }
        }
    }
    
    private func searchOptionButton(for option: SearchOption) -> some View {
        Button {
            withAnimation { selectedSearchOption = option }
        } label: {
            SearchOptionButtonLabel(selectedSearchOption: $selectedSearchOption, option: option)
        }
    }
    
    private func resetFields() {
        searchByDate = ""
        searchByPart = ""
        searchByText = ""
    }
}



#Preview {
    ZStack{
        SearchView(isSearcinhgActive: .constant(false), viewModel: HappyHourViewModel(context: CoreDataHelper.shared.persistentContainer.viewContext))
    }
}
