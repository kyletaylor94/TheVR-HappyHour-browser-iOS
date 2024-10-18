//
//  CustomSearchButton.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct CustomSearchButton: View {
    @Binding var isSearchingActive: Bool
    var body: some View {
        Button(action: {
            withAnimation {
                isSearchingActive = true
            }
        }, label: {
            RoundedRectangle(cornerRadius: Constants.CornerRadius.ten)
                .foregroundStyle(.searchButtonBackGround)
                .frame(width: 60,height: 60)
                .overlay{
                    Image(systemName: Constants.Icons.search)
                        .foregroundStyle(.white)
                        .font(.title3)
                }
        })
        
    }
}
