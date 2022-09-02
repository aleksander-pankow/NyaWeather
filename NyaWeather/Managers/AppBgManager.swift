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
      let MORNING = 6
      let AFTERNOON = 6
      let EVENING = 18
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
      case EVENING..<MIDNIGHT:
          appBackground = Color("SunEvening").edgesIgnoringSafeArea(.all)
      default:
          _ = Color("SunMorning").edgesIgnoringSafeArea(.all)
      }
      
      return appBackground
    }
}
