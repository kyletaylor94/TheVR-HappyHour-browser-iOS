//
//  ContentView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var happyHourVM: HappyHourViewModel
    
    var body: some View {
        HomeView(happyHourVM: happyHourVM)
    }
}




#Preview {
    ContentView(happyHourVM: HappyHourViewModel())
}

