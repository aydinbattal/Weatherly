//
//  ContentView.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-11.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var weatherFetcher : WeatherHelper
    @EnvironmentObject var locationFetcher : LocationHelper
    
    var body: some View {
        VStack{
            if(self.locationFetcher.currentLocation != nil){
                if(self.weatherFetcher.weatherInfo != nil){
                    List{
                        Section(header: Text("Location Information")) {
                            Text("Name: \( self.weatherFetcher.weatherInfo!.name)")
                            Text("Region: \( self.weatherFetcher.weatherInfo!.region)")
                            Text("Country: \( self.weatherFetcher.weatherInfo!.country)")
                            Text("Latitude: \( self.locationFetcher.currentLocation!.coordinate.latitude)")
                            Text("Longtitude: \( self.locationFetcher.currentLocation!.coordinate.longitude)")
                        }
                        Section(header: Text("Weather Information")) {
                            Text("Temperature: \( self.weatherFetcher.weatherInfo!.temp)°C")
                            Text("Feels Like: \( self.weatherFetcher.weatherInfo!.feelslike)°C")
                            Text("Wind: \( self.weatherFetcher.weatherInfo!.windKph)kph, \(self.weatherFetcher.weatherInfo!.windDir)")
                            Text("Humidity: \( self.weatherFetcher.weatherInfo!.humidity)%")
                            Text("UV: \( self.weatherFetcher.weatherInfo!.uv)")
                            Text("Vis: \( self.weatherFetcher.weatherInfo!.visKm)km")
                            Text("Condition: \( self.weatherFetcher.weatherInfo!.conditionText)")
                        }
                    }
                }
                
                
            }else{
                Text("Obtaining user location...")
            }
        }
        .onAppear(){
            self.locationFetcher.checkPermission()
            self.weatherFetcher.fetchDataFromAPI(lat: self.locationFetcher.currentLocation!.coordinate.latitude, lon: self.locationFetcher.currentLocation!.coordinate.longitude)
        }
        .onChange(of: self.locationFetcher.currentLocation, perform: { _ in
            self.weatherFetcher.fetchDataFromAPI(lat: self.locationFetcher.currentLocation!.coordinate.latitude, lon: self.locationFetcher.currentLocation!.coordinate.longitude)
        })
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
