//
//  HappyHourBrowserApp.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI

@main
struct HappyHourBrowserApp: App {
    
    @StateObject var viewModel = HappyHourViewModel(context: CoreDataHelper.shared.persistentContainer.viewContext)
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .environment(\.managedObjectContext,
                              CoreDataHelper.shared.persistentContainer.viewContext)
        }
    }
}
