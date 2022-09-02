//
//  WelcomeView.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 21/08/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        Text("Welcome")
            .onAppear(){
                locationManager.requestLocation()
            }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
