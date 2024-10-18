//
//  ContentView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

struct ContentView: View {
    @AppStorage("disclaimer") var disclaimer: Bool = false
    @State private var showDisclaimerAlert: Bool = false
    @ObservedObject var viewModel: HappyHourViewModel
    
    var body: some View {
        HomeView(viewModel: viewModel)
            .environment(\.managedObjectContext, CoreDataHelper.shared.persistentContainer.viewContext)
        
            .onAppear{
                if !disclaimer {
                    showDisclaimerAlert = true
                }
            }
            .alert(isPresented: $showDisclaimerAlert) {
                createDisclamerAlert()
            }
    }
}

extension ContentView {
    func createDisclamerAlert() -> Alert {
        return Alert(
            title: Text("Disclaimer"),
            message: Text("This is a hobby project from fans and not officially related to TheVR."),
            dismissButton: .default(Text("Acknowledged")) {
                disclaimer = true
            }
        )
    }
}


#Preview {
    ContentView(viewModel: HappyHourViewModel(context: CoreDataHelper.shared.persistentContainer.viewContext))
}

