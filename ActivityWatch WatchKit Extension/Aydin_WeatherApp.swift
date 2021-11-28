//
//  Aydin_WeatherApp.swift
//  ActivityWatch WatchKit Extension
//
//  Created by Aydin Battal on 2021-11-27.
//

import SwiftUI

@main
struct Aydin_WeatherApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
