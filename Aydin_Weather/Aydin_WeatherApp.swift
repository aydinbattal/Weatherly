//
//  Aydin_WeatherApp.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-11.
//

import SwiftUI

@main
struct Aydin_WeatherApp: App {
    
    let locationHelper = LocationHelper()
    let weatherHelper = WeatherHelper()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationHelper)
                .environmentObject(weatherHelper)
        }
    }
}
