//
//  WeatherViewItem.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 02/09/2022.
//

import SwiftUI

struct WeatherViewItem: View {
    @ObservedObject var weather: WeatherItem
    
    var body: some View {
        VStack(spacing: 16) {
            Text(weather.name ?? "null")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("\(Int(weather.temp.rounded()))°")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .lineLimit(3)
            Text(weather.desc?.capitalized ?? "null")
                .font(.headline)
                .foregroundColor(.secondary)
            HStack{
                Image("wind")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.white)
                    .frame(width: 25.0, height: 25.0)
                Text("\(Int(weather.wind.rounded()))")
                Text("km/s")
                    .font(.footnote)
                    .opacity(0.4)
            }
        }
    }
}
