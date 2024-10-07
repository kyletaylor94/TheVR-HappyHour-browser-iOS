//
//  BackgroundPicture.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct BackgroundPicture: View {
    var body: some View {
        Color.black.ignoresSafeArea()
        Image(.topo)
            .resizable()
            .frame(height: UIScreen.main.bounds.height)
            .blur(radius: 2)

    }
}
