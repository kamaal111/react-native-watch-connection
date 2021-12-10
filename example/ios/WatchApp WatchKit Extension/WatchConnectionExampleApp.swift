//
//  WatchConnectionExampleApp.swift
//  WatchApp WatchKit Extension
//
//  Created by Kamaal Farah on 10/12/2021.
//

import SwiftUI

@main
struct WatchConnectionExampleApp: App {
    @StateObject private var chronos = Chronos()

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(chronos)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
