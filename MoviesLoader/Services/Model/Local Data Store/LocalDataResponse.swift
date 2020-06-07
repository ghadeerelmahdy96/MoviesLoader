//
//  LocalDataResponse.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/6/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
enum LocalDataResponseError : Error{
  case saving
  case fetching
  
  var reason: String {
    switch self {
    case .saving:
      return "An error occurred while saving data ".localizedString
    case .fetching:
      return "An error occurred while fetching data".localizedString
    }
  }
}
