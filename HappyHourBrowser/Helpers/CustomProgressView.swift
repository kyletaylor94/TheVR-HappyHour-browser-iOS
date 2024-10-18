//
//  CustomProgressView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 07..
//

import SwiftUI
import SwiftfulLoadingIndicators

struct CustomProgressView: View {
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: Constants.CornerRadius.twelve)
                .frame(width: 120, height: 120)
                .foregroundStyle(.cellBG)
                .overlay {
                    VStack(spacing: 12){
                        LoadingIndicator(animation: .threeBallsTriangle, color: .searchButtonBackGround, size: .medium)
                        Text("Loading...")
                            .font(.title3)
                            .foregroundStyle(.black)
                    }
                }
        }
    }
}

#Preview {
    ZStack{
        BackgroundPicture()
        CustomProgressView()
    }
}
