//
//  StandZoneApp.swift
//  StandZone WatchKit Extension
//
//  Created by yifanlan on 3/16/22.
//

import SwiftUI

@main
struct StandZoneApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
