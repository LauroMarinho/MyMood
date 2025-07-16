//
//  MyMoodApp.swift
//  MyMood
//
//  Created by Lauro Marinho on 21/04/25.
//

import SwiftUI

@main
struct MyMoodApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

