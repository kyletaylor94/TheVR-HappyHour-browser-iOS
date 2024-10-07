//
//  SearchButton.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 07..
//

import Foundation
import SwiftUI

struct SearchButton: View {
    @Binding var navigateToResult: Bool
    @Binding var textFieldIsEmpty: Bool
    
    var body: some View {
        Button(action: {
            navigateToResult = true
            
        }, label: {
            HStack {
                Image(systemName: Constants.shared.searchIcon)
                
                Text("Search")
            }
            .font(.title2)
            .foregroundStyle(.gray)
        })
        .disabled(textFieldIsEmpty ? true : false)
        .frame(width: 150, height: 50)
        .background(
            RoundedRectangle(cornerRadius: Constants.shared.cornerRadiusEight)
                .foregroundStyle(textFieldIsEmpty ? .searchSelectedOptionBG : .searchButtonBackGround)
        )
    }
}
