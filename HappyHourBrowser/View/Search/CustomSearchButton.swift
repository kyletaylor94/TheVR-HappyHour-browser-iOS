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
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.searchButtonBackGround)
                .frame(width: 60,height: 60)
                .overlay{
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                        .font(.title3)
                }
        })
        
    }
}
