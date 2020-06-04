//
//  AllMovies.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
struct AllMovies: Codable {
    var page, totalResults, totalPages: Int
    var results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
