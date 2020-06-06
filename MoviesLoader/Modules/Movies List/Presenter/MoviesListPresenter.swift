//
//  MoviesListPresenter.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
final class MoviesListPresenter {

     private var viewControllor : MoviesListViewProtocol
     private var movies: [Movie] = []
     private var currentPage = 1
     private var total = 0
     private var isFetchInProgress = false
     private var repo : RepositoryProtocol
    init(viewController : MoviesListViewProtocol) {
        self.viewControllor = viewController
        repo = RepositoryImp()
    }
    var totalCount: Int {
      return total
    }
    
    var currentCount: Int {
      return movies.count
    }
    func movie(at index: Int) -> Movie {
       return movies[index]
     }
    //MARK:- Movies List present protocol
    func fetchMovies() {
          // 1 if a fetch request is already in progress. This prevents multiple requests happening. More on that later.
          guard !isFetchInProgress else {
            return
          }
          // 2 send request
          isFetchInProgress = true
          repo.getDataFromAPI(From: API.BASE_URL+AllMoviesRequest.path, parameters: AllMoviesRequest.parameters, page: currentPage) { [weak self] (result : Result<AllMovies, DataResponseError>) in
           switch result {
            // 3 If the request fails,
            case .failure(let error):
              DispatchQueue.main.async {
                self?.isFetchInProgress = false
                print(error.reason )
                self?.viewControllor.onFetchFailed(with: error.reason)
              }
            // 4 If the request is successful
            case .success(let response):
              DispatchQueue.main.async {
                // 1 increment the page number to retrieve after that
                self?.currentPage += 1
                self?.isFetchInProgress = false
                // 2 get total results
                self?.total = response.totalResults
                self?.movies.append(contentsOf: response.results)
                // 3 send index paths
                if response.page > 1 {
                    let indexPathsToReload = self?.calculateIndexPathsToReload(from: response.results)
                    self?.viewControllor.onFetchCompleted(with: indexPathsToReload)
                } else {
                    self?.viewControllor.onFetchCompleted(with: .none)
                }
              }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
      let startIndex = movies.count - newMovies.count
      let endIndex = startIndex + newMovies.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
