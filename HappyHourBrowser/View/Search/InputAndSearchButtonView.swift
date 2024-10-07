//
//  InputAndSearchButtonView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 07..
//

import SwiftUI

struct InputAndSearchButtonView: View {
    @Binding var selectedSearchOption: SearchOption
    @Binding var textFieldIsEmpty: Bool
    
    @Binding var searchByPart: String
    @Binding var searchByDate: String
    @Binding var searchByText: String
    
    @Binding var currentDate: Date
    
    @Binding var navigateToResult: Bool
    
    @ObservedObject var viewModel: HappyHourViewModel
    
    var textfieldInputDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 20){
            switch selectedSearchOption {
            case .byPart:
                SearchField(searchByText: $searchByPart, placeholder: "Part")
                    .onChange(of: searchByPart) { _, newValue in
                        textFieldIsEmpty = newValue.isEmpty
                        if let partNumber = Int(newValue), partNumber > 0 && partNumber < 2000 {
                            searchByPart = String(partNumber)
                        } else {
                            searchByPart = ""
                        }
                    }
                    .keyboardType(.numberPad)
                
            case .byDate:
                CustomDatePicker(currentDate: $currentDate)
                .onChange(of: currentDate) { _, newValue in
                    let formattedDate = textfieldInputDateFormatter.string(from: newValue)
                    searchByDate = formattedDate
                    textFieldIsEmpty = false
                }
                
            case .byText:
                SearchField(searchByText: $searchByText, placeholder: "Searched text")
                    .onChange(of: searchByText) { _, newValue in
                        searchByText = newValue.filter { $0.isLetter }
                        textFieldIsEmpty = newValue.isEmpty
                    }
                    .keyboardType(.alphabet)
                
            }
            
            SearchButton(navigateToResult: $navigateToResult, textFieldIsEmpty: $textFieldIsEmpty)
                .navigationDestination(isPresented: $navigateToResult, destination: {
                    switch selectedSearchOption {
                    case .byPart:
                        ResultsView(viewModel: viewModel ,searchedText: $searchByPart, selectedOption: selectedSearchOption)
                        
                    case .byDate:
                        ResultsView(viewModel: viewModel ,searchedText: $searchByDate, selectedOption: selectedSearchOption)
                        
                    case .byText:
                        ResultsView(viewModel: viewModel ,searchedText: $searchByText, selectedOption: selectedSearchOption)
                    }
                })
        }
        .frame(width: 300, height: 150)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 250)
                .foregroundStyle(.white.opacity(0.8))
        )
    }
}
