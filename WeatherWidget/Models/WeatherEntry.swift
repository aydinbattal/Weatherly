//
//  WeatherEntry.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-28.
//

import Foundation
import WidgetKit

struct WeatherEntry: TimelineEntry {
    let date = Date()
    let weather : Weather
}
