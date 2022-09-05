//
//  WeatherView.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 21/08/2022.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var weather: WeatherItem
    @StateObject var vm = WeatherViewModel()
    
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
                Text("km/h")
                    .font(.footnote)
                    .opacity(0.4)
            }
            Text(vm.getCurrentTips(condition: weather.condition ?? "Empty", description: weather.desc ?? "Empty"))
                .multilineTextAlignment(.center)
            Button("Delete"){
                CoreDataManager.shared.delete(item: self.weather)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 30)
        .padding()
    }
}
