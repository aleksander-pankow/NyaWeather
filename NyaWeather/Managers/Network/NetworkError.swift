//
//  NetworkError.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 16/08/2022.
//

import Foundation

struct NetworkError: Error {
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
