//
//  Provider.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-28.
//

import Foundation
import WidgetKit
import SwiftUI

//controller
//data provider

struct Provider: TimelineProvider {
    @ObservedObject var weatherFetcher = WeatherHelper()
    @ObservedObject var locationFetcher = LocationHelper()
//    @EnvironmentObject var weatherFetcher : WeatherHelper
//    @EnvironmentObject var locationFetcher : LocationHelper
    
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(weather: Weather())
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(weather: Weather())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        var entries: [WeatherEntry] = []
        let refresh = Calendar.current.date(byAdding: .second, value: 10, to: Date()) ?? Date()

        self.locationFetcher.checkPermission()
//        self.weatherFetcher.fetchDataFromAPI(lat: self.locationFetcher.currentLocation?.coordinate.latitude ?? 43.4691, lon: self.locationFetcher.currentLocation?.coordinate.longitude ?? -79.7)
        
        self.weatherFetcher.fetchDataFromAPIForWidget(lat: self.locationFetcher.currentLocation?.coordinate.latitude ?? 43.4691, lon: self.locationFetcher.currentLocation?.coordinate.longitude ?? -79.7, withCompletion: {wthr in
            entries.append(WeatherEntry(weather: wthr ?? Weather()))
            let timeline = Timeline(entries: entries, policy: .after(refresh))
            completion(timeline)
        })
        
//        entries.append(WeatherEntry(weather: self.weatherFetcher.weatherInfo ?? Weather()))
//        let timeline = Timeline(entries: entries, policy: .after(refresh))
//        completion(timeline)

    }
}
