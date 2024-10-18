//
//  SearchTopView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct SearchTopView: View {
    @Binding var isSearcinhgActive: Bool
    
    var body : some View {
        HStack(spacing: 10){
            Spacer()
            
            Image(systemName: Constants.Icons.search)
                .font(.title3)
                .foregroundStyle(.searchSelectedOptionBG)
            
            Text("Search")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundStyle(.searchSelectedOptionBG)
            
            Spacer()
            
            Button {
                withAnimation {
                    isSearcinhgActive = false
                }
            } label: {
                Image(systemName: Constants.Icons.xMark)
                    .foregroundStyle(.white)
                    .font(.title2)
            }
            
        }
        .padding(.horizontal)
    }
}
