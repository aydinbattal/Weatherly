//
//  Weather.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-12.
//

import Foundation
import UIKit

struct Condition: Decodable{
    let text : String
}

struct Weather : Codable{
    let name: String
    let region: String
    let country: String
    let lat: Float
    let lon: Float
    let temp: Float
    let feelslike: Float
    let windKph: Float
    let windDir: String
    let humidity: Int
    let uv: Int
    let visKm: Int
    let conditionText: String
    
    enum WeatherKeys: String, CodingKey{
        case location
        case current
        
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
    }
    
    
    
    init(from decoder: Decoder) throws {
        let weatherContainer = try decoder.container(keyedBy: WeatherKeys.self)
        
        let locationContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.LocationKeys.self, forKey: .location)
        
        self.name = try locationContainer.decodeIfPresent(String.self, forKey: .name) ?? "Unavailable"
        self.region = try locationContainer.decodeIfPresent(String.self, forKey: .region) ?? "Unavailable"
        self.country = try locationContainer.decodeIfPresent(String.self, forKey: .country) ?? "Unavailable"
        self.lat = try locationContainer.decodeIfPresent(Float.self, forKey: .lat) ?? 0.0
        self.lon = try locationContainer.decodeIfPresent(Float.self, forKey: .lon) ?? 0.0
        
        let currentContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.CurrentKeys.self, forKey: .current)
        
        self.temp = try currentContainer.decodeIfPresent(Float.self, forKey: .temp) ?? 0.0
        self.feelslike = try currentContainer.decodeIfPresent(Float.self, forKey: .feelslike) ?? 0.0
        self.windKph = try currentContainer.decodeIfPresent(Float.self, forKey: .windKph) ?? 0.0
        self.windDir = try currentContainer.decodeIfPresent(String.self, forKey: .windDir) ?? "Unavailable"
        self.humidity = try currentContainer.decodeIfPresent(Int.self, forKey: .humidity) ?? 0
        self.uv = try currentContainer.decodeIfPresent(Int.self, forKey: .uv) ?? 0
        self.visKm = try currentContainer.decodeIfPresent(Int.self, forKey: .visKm) ?? 0
        
        let conditionContainer = try currentContainer.nestedContainer(keyedBy: WeatherKeys.CurrentKeys.ConditionKeys.self, forKey: .condition)
        
        self.conditionText = try conditionContainer.decodeIfPresent(String.self, forKey: .text) ?? "Unavailable"

    }
    
    func encode(to encoder: Encoder) throws {
        //nothing to be done
    }
}
