//
//  SearchOptionButtonLabel.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 07..
//

import SwiftUI

struct SearchOptionButtonLabel: View {
    @Binding var selectedSearchOption: SearchOption
    var option: SearchOption
    
    var body: some View {
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
        .padding(.horizontal)
        .frame(width: 250,height: 70)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(selectedSearchOption == option ? .chapterCell : .searchSelectedOptionBG)
        )
    }
}

