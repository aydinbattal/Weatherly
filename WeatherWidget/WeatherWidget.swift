//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Aydin Battal on 2021-11-28.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidget: Widget {
    let kind: String = "com.aydinbattal.Aydin_Weather.WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("This is a widget to suggest some activities to do.")
        .supportedFamilies([.systemLarge, .systemSmall])
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    
    static var previews: some View {
//        WeatherWidgetEntryView(entry: WeatherEntry(weather: Weather()))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
        WeatherWidgetEntryView(entry: WeatherEntry(weather: Weather()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
//
//        WeatherWidgetEntryView(entry: WeatherEntry(Weather: Weather()))
//            .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
//
        WeatherWidgetEntryView(entry: WeatherEntry(weather: Weather()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

