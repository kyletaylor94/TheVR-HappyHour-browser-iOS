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
    
    @ObservedObject var happyHourVM: HappyHourViewModel
    @ObservedObject var spotifyVM: SpotifyViewModel
    
    
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
                        guard let firstPart = happyHourVM.allVideos.first?.part else {
                            searchByPart = ""
                            textFieldIsEmpty = true
                            return
                        }

                        if let partNumber = Int(newValue), partNumber > 0 && partNumber <= firstPart {
                            searchByPart = String(partNumber)
                            textFieldIsEmpty = false
                        } else {
                            searchByPart = ""
                            textFieldIsEmpty = true
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
                        ResultsView(happyHourVM: happyHourVM, spotifyVM: spotifyVM ,searchedText: $searchByPart, selectedOption: selectedSearchOption)
                        
                    case .byDate:
                        ResultsView(happyHourVM: happyHourVM ,spotifyVM: spotifyVM, searchedText: $searchByDate, selectedOption: selectedSearchOption)
                        
                    case .byText:
                        ResultsView(happyHourVM: happyHourVM,spotifyVM: spotifyVM ,searchedText: $searchByText, selectedOption: selectedSearchOption)
                    }
                })
        }
        .frame(width: 300, height: 150)
        .background(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.eight)
                .frame(width: 250)
                .foregroundStyle(.white.opacity(0.8))
        )
    }
}

#Preview {
    InputAndSearchButtonView(selectedSearchOption: .constant(.byText), textFieldIsEmpty: .constant(true), searchByPart: .constant(""), searchByDate: .constant(""), searchByText: .constant(""), currentDate: .constant(Date()) , navigateToResult: .constant(false), happyHourVM: HappyHourViewModel(), spotifyVM: SpotifyViewModel())
}
