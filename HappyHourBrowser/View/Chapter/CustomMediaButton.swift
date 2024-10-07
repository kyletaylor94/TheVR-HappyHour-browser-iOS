//
//  CustomMediaButton.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct CustomMediaButton: View {
    let url: String
    let iconName: String
    let titleName: String
    
    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack {
                Image(systemName: iconName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.7))
                
                Spacer()
                
                Text(titleName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.7))
                
                Spacer()
            }
        }
        .padding(.horizontal, 3)
        .frame(width: UIScreen.main.bounds.width - 32, height: 30)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.chapterCell))
                .stroke(Color(.searchButtonBackGround))
        )
    }
}

#Preview {
    CustomMediaButton(url: "https//google.com", iconName: "house", titleName: "Play on Youtube")
}
