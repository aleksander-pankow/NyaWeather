//
//  WeatherView_Preview.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 24/08/2022.
//

import SwiftUI

struct WeatherView_Preview: View {
    
    var body: some View {
        VStack {
            Text("Kelsterbach")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("Title 2")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .lineLimit(3)
            Text("author.uppercased()")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .border(.white)
    }
}

struct WeatherView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView_Preview()
    }
}
