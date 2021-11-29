//
//  WeatherEntryView.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-28.
//

import Foundation
import SwiftUI

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    @ObservedObject var weatherFetcher = WeatherHelper()
    @ObservedObject var locationFetcher = LocationHelper()
    
    var body: some View {
        VStack{
            Text("\( self.entry.weather.name)")
                .padding(.top)
            Text("\( self.entry.weather.temp, specifier: "%.1f")°C")
                .font(.system(size: 30))
            Text("\( self.entry.weather.conditionText)")
            Image(uiImage: (self.entry.weather.image ?? UIImage(systemName: "cloud.sun.fill"))!)
        }
//        .onChange(of: self.locationFetcher.currentLocation, perform: { _ in
//            self.weatherFetcher.fetchDataFromAPI(lat: self.locationFetcher.currentLocation!.coordinate.latitude, lon: self.locationFetcher.currentLocation!.coordinate.longitude)
//        })
    }
}
