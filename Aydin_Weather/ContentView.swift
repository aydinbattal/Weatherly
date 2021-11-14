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
                List{
                Section(header: Text("Location Information")) {
                    Text("Latitude: \( self.locationFetcher.currentLocation!.coordinate.latitude)")
                    Text("Longtitude: \( self.locationFetcher.currentLocation!.coordinate.longitude)")
                }
                }
                
                Button(action: {
                    self.weatherFetcher.fetchDataFromAPI(lat: self.locationFetcher.currentLocation!.coordinate.latitude, lon: self.locationFetcher.currentLocation!.coordinate.longitude)
                }){
                    Text("Fetch")
                        
                }
                
                
            }else{
                Text("Obtaining user location...")
            }
        }
        .onAppear(){
            self.locationFetcher.checkPermission()
        }
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
