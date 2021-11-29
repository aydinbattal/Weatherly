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
//    var apiKey = "db097f9288f14f46bf142323211311"
//    var apiURL = "https://api.weatherapi.com/v1/current.json?key=db097f9288f14f46bf142323211311&q="
    
    init(){
    }

    func fetchDataFromAPIForWidget(lat : Double, lon : Double, withCompletion completion: @escaping (Weather?) -> Void){
        var apiURL = "https://api.weatherapi.com/v1/current.json?key=db097f9288f14f46bf142323211311&q="
        
        apiURL = apiURL + "\(lat)," + "\(lon)"
        
        guard let api = URL(string: apiURL) else{
            print(#function, "Unable to obtain URL from String")
            return
        }
        print("api", api)
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
                                        var decodedWeatherInfo = try decoder.decode(Weather.self, from: jsonData)
                                        
                                        if (decodedWeatherInfo.imageURL != nil){
                                            //initiate network call to get image
//                                            let imgStr = decodedWeatherInfo.imageURL?.absoluteString.replacingOccurrences(of: "//", with: "")
//                                            let imgUrl = URL(string: imgStr!)
                                            
                                            let imgStr = "https:" + decodedWeatherInfo.imageURL!.absoluteString
                                            let imgUrl = URL(string: imgStr)
    
                                            self.fetchImage(from: imgUrl!, withCompletion: { data in
                                                
                                                guard let imageData = data else{
                                                    print(#function, "Image data not obtained")
                                                    return
                                                }
                                                
                                                
                                                decodedWeatherInfo.image = UIImage(data: imageData)
                                                
                                                DispatchQueue.main.async {
                                                    self.weatherInfo = decodedWeatherInfo
                                                    completion(decodedWeatherInfo)
                                                }
                                            })
                                            print(#function, self.weatherInfo)
                                            
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
    
    func fetchDataFromAPI(lat : Double, lon : Double){
        var apiURL = "https://api.weatherapi.com/v1/current.json?key=db097f9288f14f46bf142323211311&q="
        
        apiURL = apiURL + "\(lat)," + "\(lon)"
        
        guard let api = URL(string: apiURL) else{
            print(#function, "Unable to obtain URL from String")
            return
        }
        print("api", api)
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
                                        var decodedWeatherInfo = try decoder.decode(Weather.self, from: jsonData)
                                        
                                        if (decodedWeatherInfo.imageURL != nil){
                                            //initiate network call to get image
//                                            let imgStr = decodedWeatherInfo.imageURL?.absoluteString.replacingOccurrences(of: "//", with: "")
//                                            let imgUrl = URL(string: imgStr!)
                                            
                                            let imgStr = "https:" + decodedWeatherInfo.imageURL!.absoluteString
                                            let imgUrl = URL(string: imgStr)
    
                                            self.fetchImage(from: imgUrl!, withCompletion: { data in
                                                
                                                guard let imageData = data else{
                                                    print(#function, "Image data not obtained")
                                                    return
                                                }
                                                
                                                
                                                decodedWeatherInfo.image = UIImage(data: imageData)
                                                
                                                DispatchQueue.main.async {
                                                    self.weatherInfo = decodedWeatherInfo
                                                }
                                            })
                                            print(#function, self.weatherInfo)
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
    
    private func fetchImage(from url: URL, withCompletion completion: @escaping (Data?) -> Void){
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if (data != nil){
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        })
        
        task.resume()
        
    }
}
