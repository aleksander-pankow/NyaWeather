//
//  LoadingView.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 21/08/2022.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
