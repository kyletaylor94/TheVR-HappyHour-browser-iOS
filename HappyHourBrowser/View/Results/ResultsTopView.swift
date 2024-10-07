//
//  ResultsTopView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct ResultsTopView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchedText: String
    
    var body: some View {
        HStack(spacing: 20){
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.white)
                    .font(.title3)
            }
            
            Text("Result for: \(searchedText)")
                .font(.title3)
                .foregroundStyle(.white)
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width, height: 50)
        .background(
            Rectangle()
                .foregroundStyle(.backGround)
        )
    }
}

#Preview {
    ResultsTopView(searchedText: .constant(""))
}
