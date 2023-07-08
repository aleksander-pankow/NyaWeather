//
//  WeatherListViewItem.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 25/09/2022.
//

import SwiftUI

struct WeatherListViewItem: View {
    
    @ObservedObject var weather: WeatherItem
    @StateObject var vm = WeatherViewModel()
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(weather.name ?? "null")
                        .foregroundColor(Color.white)
                    Text("Hessen, Germany")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .trailing){
                    Text("\(Int(weather.temp.rounded()))°")
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
        .background(Color("Default"))
    }
}

//struct WeatherListViewItem_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherListViewItem()
//    }
//}
