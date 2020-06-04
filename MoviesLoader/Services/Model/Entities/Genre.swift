//
//  Genre.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
// MARK: - Genres
struct Genres: Codable {
    var genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int
    var name: String
}
