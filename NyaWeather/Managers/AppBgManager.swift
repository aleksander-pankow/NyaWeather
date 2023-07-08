//
//  AppBgService.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 01/09/2022.
//

import Foundation
import SwiftUI

class AppBgManager {
    static func appBackground() -> some View {
      let hour = Calendar.current.component(.hour, from: Date())
      
      let NEW_DAY = 0
      let MORNING = 5
      let AFTERNOON = 11
      let EVENING = 16
      let LATEVENING = 20
      let MIDNIGHT = 24
      
      var appBackground = Color("SunMorning").edgesIgnoringSafeArea(.all) // Default Color
      switch hour {
      case NEW_DAY..<MORNING:
          appBackground = Color("Night").edgesIgnoringSafeArea(.all)
      case MORNING..<AFTERNOON:
          appBackground = Color("SunMorning").edgesIgnoringSafeArea(.all)
      case AFTERNOON..<EVENING:
          appBackground = Color("SunAfternoon").edgesIgnoringSafeArea(.all)
          print("AfterNoon")
      case EVENING..<LATEVENING:
          appBackground = Color("SunEvening").edgesIgnoringSafeArea(.all)
      case LATEVENING..<MIDNIGHT:
          appBackground = Color("LateEvening").edgesIgnoringSafeArea(.all)
      default:
          _ = Color("SunMorning").edgesIgnoringSafeArea(.all)
      }
      
      return appBackground
    }
}
