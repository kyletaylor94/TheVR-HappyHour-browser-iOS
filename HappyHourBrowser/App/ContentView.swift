//
//  ContentView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct ContentView: View {
//    @AppStorage("disclaimer") var disclaimer: Bool = false
//    @State private var showDisclaimerAlert: Bool = false
    @ObservedObject var viewModel: HappyHourViewModel
    
    var body: some View {
        HomeView(viewModel: viewModel)
//            .onAppear{
//                if !disclaimer {
//                    showDisclaimerAlert = true
//                }
//            }
//            .alert(isPresented: $showDisclaimerAlert) {
//                createDisclamerAlert()
//            }
    }
}




#Preview {
    ContentView(viewModel: HappyHourViewModel())
}

