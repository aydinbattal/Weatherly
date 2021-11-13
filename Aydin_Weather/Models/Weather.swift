//
//  Weather.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-12.
//

import Foundation
import UIKit

struct Weather : Codable{
    let name: String
    let region: String
    let country: String
    let lat: String
    let lon: String
    let temp: String
    let feelslike: String
    let windKph: String
    let windDir: String
    let humidity: String
    let uv: String
    let visKm: String
    let conditionText: String
    
    enum LocationKeys: String, CodingKey{
        case name
        case region
        case country
        case lat
        case lon
    }
    
    enum CurrentKeys: String, CodingKey{
        case temp = "temp_c"
        case feelslike = "feelslike_c"
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case humidity
        case uv
        case visKm = "vis_km"
        case condition
        
        enum ConditionKeys: String, CodingKey{
            case text
        }
    }
    
    init(from decoder: Decoder) throws {
        let locationContainer = try decoder.container(keyedBy: LocationKeys.self)
        
        self.name = try locationContainer.decodeIfPresent(String.self, forKey: .name) ?? "Unavailable"
        self.region = try locationContainer.decodeIfPresent(String.self, forKey: .region) ?? "Unavailable"
        self.country = try locationContainer.decodeIfPresent(String.self, forKey: .country) ?? "Unavailable"
        self.lat = try locationContainer.decodeIfPresent(String.self, forKey: .lat) ?? "Unavailable"
        self.lon = try locationContainer.decodeIfPresent(String.self, forKey: .lon) ?? "Unavailable"
        
        let currentContainer = try decoder.container(keyedBy: CurrentKeys.self)
        
        self.temp = try currentContainer.decodeIfPresent(String.self, forKey: .temp) ?? "Unavailable"
        self.feelslike = try currentContainer.decodeIfPresent(String.self, forKey: .feelslike) ?? "Unavailable"
        self.windKph = try currentContainer.decodeIfPresent(String.self, forKey: .windKph) ?? "Unavailable"
        self.windDir = try currentContainer.decodeIfPresent(String.self, forKey: .windDir) ?? "Unavailable"
        self.humidity = try currentContainer.decodeIfPresent(String.self, forKey: .humidity) ?? "Unavailable"
        self.uv = try currentContainer.decodeIfPresent(String.self, forKey: .uv) ?? "Unavailable"
        self.visKm = try currentContainer.decodeIfPresent(String.self, forKey: .visKm) ?? "Unavailable"
        
        let conditionContainer = try currentContainer.nestedContainer(keyedBy: CurrentKeys.ConditionKeys.self, forKey: .condition)
        
        self.conditionText = try conditionContainer.decodeIfPresent(String.self, forKey: .text) ?? "Unavailable"
        
    }
    
    func encode(to encoder: Encoder) throws {
        //nothing to be done
    }
}
