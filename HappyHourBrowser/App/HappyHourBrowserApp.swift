//
//  HappyHourBrowserApp.swift
//  HappyHourBrowser
//
//  Created by Turdesan Csaba on 2024. 10. 06..
//




import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct HappyHourBrowserApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    @StateObject private var viewModel: HappyHourViewModel
    
    init() {
        guard let resolvedViewModel = DependencyContainer.shared.container.resolve(HappyHourViewModel.self) else {
            print("firstartime error")
            preconditionFailure("Failed to resolve: \(HappyHourViewModel.self)")
        }
        _viewModel = StateObject(wrappedValue: resolvedViewModel)
    }
    
   
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
