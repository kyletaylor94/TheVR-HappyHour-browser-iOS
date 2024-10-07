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
                Image(systemName: Constants.shared.backButtonIcon)
            }
            
            Text("Result for: \(searchedText)")
              
            Spacer()
        }
        .font(.title3)
        .foregroundStyle(.white)
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
