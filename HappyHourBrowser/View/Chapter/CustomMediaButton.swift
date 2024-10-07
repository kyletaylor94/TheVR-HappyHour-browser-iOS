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
    let width: CGFloat
        
    var body: some View {
        if let validUrl = URL(string: url) {
            Link(destination: validUrl) {
                HStack {
                    Image(systemName: iconName)
                        .font(.title2)
                    
                    Spacer()
                    
                    Text(titleName)
                        .font(.subheadline)
                    
                    Spacer()
                }
            }
            .fontWeight(.semibold)
            .foregroundStyle(Constants.shared.chapterBlackColor)
            .padding(.horizontal, 3)
            .frame(width: width, height: 30)
            .background(
                RoundedRectangle(cornerRadius: Constants.shared.cornerRadiusEight)
                    .fill(.chapterCell)
                    .stroke(.searchButtonBackGround)
            )
        }
    }
}

#Preview {
    CustomMediaButton(url: "https//google.com", iconName: "house", titleName: "Play on Youtube",width: UIScreen.main.bounds.width - 32)
}
