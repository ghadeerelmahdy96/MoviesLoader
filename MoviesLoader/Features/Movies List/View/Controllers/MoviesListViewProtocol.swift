//
//  MoviesListProtocol.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
protocol MoviesListViewProtocol {
     func onFetchFailed(with reason: String)
     func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
     func showEmptyLocalData ()
}
