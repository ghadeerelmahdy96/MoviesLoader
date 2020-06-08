//
//  MovieDetailsPresenter.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/8/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
class MovieDetailsPresenter {
    let viewController : MovieDetailsProtocol
    let movie:Movie
    init(movie:Movie ,viewController: MovieDetailsProtocol) {
        self.viewController = viewController
        self.movie = movie
        self.viewController.showData(movie: movie)
    }
}
