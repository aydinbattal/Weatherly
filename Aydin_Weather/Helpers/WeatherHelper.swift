//
//  ApiHelper.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-12.
//

import Foundation
import UIKit

class WeatherHelper : ObservableObject{
    @Published var weatherInfo : Weather?
    //https://api.weatherapi.com/v1/current.json?key=db097f9288f14f46bf142323211311&q=+40.75921100,-73.98463800
    var apiKey = "db097f9288f14f46bf142323211311"
    var apiURL = "https://api.weatherapi.com/v1/current.json?key=db097f9288f14f46bf142323211311&q=+40.75921100,-73.98463800"
    
    init(){
        self.fetchDataFromAPI()
    }
    
    //https://api.spacexdata.com/v4/launches/city=florida
    //    func fetchDataFromAPI(string cityName){
    ////        apiURL = apiURL + "/city=\(cityName)"
    //
    //        guard let api = URL(string: apiURL) else{
    //            print(#function, "Unable to obtain URL from String")
    //            return
    //        }
    //    }
    
    
    func fetchDataFromAPI(){
        guard let api = URL(string: apiURL) else{
            print(#function, "Unable to obtain URL from String")
            return
        }
        
        //Initiate Network call
        URLSession.shared.dataTask(with: api) {(data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(#function, error)
            }else{
                
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode == 200{
                        
                        DispatchQueue.global().async {
                            do{
                                if (data != nil){
                                    
                                    if let jsonData = data{
                                        
                                        let decoder = JSONDecoder()
                                        
                                        
                                        
                                        //indicates that you are expecting a single JSON object from API
                                        let decodedWeatherInfo = try decoder.decode(Weather.self, from: jsonData)
                                        print(#function, decodedWeatherInfo)
                                        
                                        DispatchQueue.main.async {
                                            self.weatherInfo = decodedWeatherInfo
                                        }
                                        
                                    }else{
                                        print(#function, "No JSON data recieved from API")
                                    }
                                }
                                
                            }catch let error{
                                print(#function, error)
                            }
                        }
                    }else{
                        print(#function, "No response obtained from network call")
                    }
                }
            }
        }.resume()
        
    }
}
