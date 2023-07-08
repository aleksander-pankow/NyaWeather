//
//  WeatherView_Preview.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 24/08/2022.
//

import SwiftUI

struct WeatherView_Preview: View {
    
    var body: some View {
        ZStack{
            Color("Default").edgesIgnoringSafeArea(.all)
            Image("Sun-Clear")
                .resizable()
                .frame(width: 350, height: 350)
                .padding()
                .position(x: 80, y: -20)
            VStack(spacing: 16) {
                
                Text("Kelsterbach")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("23°")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                Text("null")
                    .font(.headline)
                    .foregroundColor(.secondary)
                HStack{
                    HStack{
                        Image("wind")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 25.0, height: 25.0)
                        Text("4")
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
                        Text("44")
                        Text("%")
                            .font(.footnote)
                            .opacity(0.4)
                    }
                }
            
                Button("Delete"){
                    
                }
            }
            .frame(width: UIScreen.main.bounds.width - 30)
            .padding()
        }
    }
}

struct WeatherView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView_Preview()
    }
}
