//
//  CrashView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 11. 01..
//

import SwiftUI

struct CrashView: View {
    var body: some View {
        ZStack{
            Color.gray.opacity(0.3).ignoresSafeArea()
            VStack(spacing: 40){
                Button("Click me 1") {
                    let myString: String? = nil
                    let string2 = myString!
                }
                
                Button("Click me2") {
                    fatalError("This was a fatal crash.")
                }
                
                Button("Click me3") {
                    let array: [String] = []
                    let item = array[0]
                }
            }
        }
    }
}

#Preview {
    CrashView()
}
