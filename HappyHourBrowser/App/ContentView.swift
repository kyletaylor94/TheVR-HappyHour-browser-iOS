//
//  ContentView.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var viewModel: HappyHourViewModel
    
    var body: some View {
        HomeView(viewModel: viewModel)
            .environment(\.managedObjectContext,
                          CoreDataHelper.shared.persistentContainer.viewContext)
    }
}

#Preview {
    ContentView(viewModel: HappyHourViewModel(context: CoreDataHelper.shared.persistentContainer.viewContext))
}

