//
//  WeatherView.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 21/08/2022.
//

import SwiftUI

struct WeatherView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var weather: WeatherItem
    @StateObject var vm = WeatherViewModel()
    
    var body: some View {
        ZStack{
            Color("Default").edgesIgnoringSafeArea(.all)
            Image("Sun-Clear")
                .resizable()
                .frame(width: 350, height: 350)
                .padding()
                .position(x: 80, y: -20)
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
                    HStack{
                        Image("wind")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 25.0, height: 25.0)
                        Text("\(Int(weather.wind.rounded()))")
                        Text("m/s")
                            .font(.footnote)
                            .opacity(0.4)
                    }
                    HStack{
                        Image("wet")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 25.0, height: 25.0)
                        Text("\(Int(weather.humidity.rounded()))")
                        Text("%")
                            .font(.footnote)
                            .opacity(0.4)
                    }
                }
                ForEach(vm.tips, id: \.self) { tip in
                    Text(tip)
                }
                Button("Delete"){
                    CoreDataManager.shared.delete(item: self.weather)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 30)
            .padding()
            .task(priority: .background){
                vm.getCurrentTips(condition: weather.condition ?? "Empty", description: weather.desc ?? "Empty", humidity: weather.humidity)
            }
        }
    }
}
