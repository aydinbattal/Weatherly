//
//  ContentView.swift
//  Aydin_Weather
//
//  Created by Aydin Battal on 2021-11-11.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var weatherHelper : WeatherHelper

    var body: some View {
        Text("Hello, world!")
            .padding()
        Button("Fetch") {
            print(#function, weatherHelper.weatherInfo)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
