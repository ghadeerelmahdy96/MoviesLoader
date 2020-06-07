//
//  Network.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
typealias Parameters = [String: String]
struct API {
  static let API_KEY = "cc4b98ead655590b7b03634ebfbad00e"
  static let BASE_URL = "https://api.themoviedb.org/3"
  static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w185"
}
struct AllMoviesRequest {
  static let  path = "/discover/movie"
  static let parameters: Parameters = ["api_key": API.API_KEY, "sort_by": "primary_release_date.desc", "include_video" : "false"]
}
