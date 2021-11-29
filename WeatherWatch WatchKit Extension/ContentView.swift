//
//  ContentView.swift
//  ActivityWatch WatchKit Extension
//
//  Created by Aydin Battal on 2021-11-27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var weatherFetcher : WeatherHelper
    @EnvironmentObject var locationFetcher : LocationHelper
    
    var body: some View {
        VStack{
            if(self.locationFetcher.currentLocation != nil){
                if(self.weatherFetcher.weatherInfo != nil){
                    Text("\( self.weatherFetcher.weatherInfo!.name)")
                        .font(.system(size: 20))
                        .padding(.top)
                    Text("\( self.weatherFetcher.weatherInfo!.temp, specifier: "%.1f")°C")
                        .font(.system(size: 60))
                    Text("\( self.weatherFetcher.weatherInfo!.conditionText)")
                    Image(uiImage: self.weatherFetcher.weatherInfo!.image!)
                }
                
                
            }else{
                Text("Obtaining user location...")
            }
        }
        .onAppear(){
            self.locationFetcher.checkPermission()
            self.weatherFetcher.fetchDataFromAPI(lat: self.locationFetcher.currentLocation?.coordinate.latitude ?? 43.4691, lon: self.locationFetcher.currentLocation?.coordinate.longitude ?? -79.7)
        }
        .onChange(of: self.locationFetcher.currentLocation, perform: { _ in
            self.weatherFetcher.fetchDataFromAPI(lat: self.locationFetcher.currentLocation!.coordinate.latitude, lon: self.locationFetcher.currentLocation!.coordinate.longitude)
        })

        
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
