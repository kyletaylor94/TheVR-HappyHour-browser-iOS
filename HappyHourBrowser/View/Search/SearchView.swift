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
    
    var textfieldInputDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .center){
            SearchTopView(isSearcinhgActive: $isSearcinhgActive)
            
            VStack(alignment: .center, spacing: 20){
                
                VStack(alignment: .leading) {
                    ForEach(SearchOption.allCases, id: \.rawValue) { option in
                        Button {
                            withAnimation {
                                selectedSearchOption = option
                            }
                        } label: {
                            HStack(spacing: 20){
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .frame(height: 20)
                                    .overlay {
                                        Circle()
                                            .frame(height: 11)
                                            .opacity(selectedSearchOption == option ? 1 : 0)
                                    }
                                    .foregroundStyle(.black)
                                
                                Text(option.rawValue)
                                    .font(.subheadline)
                                    .foregroundStyle(selectedSearchOption == option ? .white : .black)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        .frame(width: 250,height: 70)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(selectedSearchOption == option ? .chapterCell : .searchSelectedOptionBG)
                        )
                    }
                }
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
                        DatePicker(selection: $currentDate, in: ...Date.now, displayedComponents: .date) {
                        }
                        .padding(.trailing, 80)
                        .frame(width: 280, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.chapterCell,style: StrokeStyle())
                        )
                        .onChange(of: currentDate) { _, newValue in
                            let formattedDate = textfieldInputDateFormatter.string(from: newValue)
                            searchByDate = formattedDate
                            print(searchByDate)
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
                    
                    Button(action: {
                        navigateToResult = true
                        
                    }, label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                            Text("Search")
                                .font(.title2)
                        }
                        .foregroundStyle(.gray)
                    })
                    .disabled(textFieldIsEmpty ? true : false)
                    
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
                    .frame(width: 150, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(textFieldIsEmpty ? .searchSelectedOptionBG : .searchButtonBackGround)
                    )
                }
                .frame(width: 300, height: 150)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.white.opacity(0.8))
                )
            }
            .padding(3)
        }
        .onAppear{
            searchByDate = ""
            searchByPart = ""
            searchByText = ""
        }
        .frame(width: UIScreen.main.bounds.width - 75, height: 480)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.backGround)
        )
    }
}



#Preview {
    ZStack{
        SearchView(isSearcinhgActive: .constant(false), viewModel: HappyHourViewModel(context: CoreDataHelper.shared.persistentContainer.viewContext))
    }
}
