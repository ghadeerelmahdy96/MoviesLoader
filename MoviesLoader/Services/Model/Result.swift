//
//  Result.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
enum Result<T:Codable, U: Error> {
  case success(T)
  case failure(U)
}
