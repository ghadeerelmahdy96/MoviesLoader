//
//  MoviesListPresenter.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
final class MoviesListPresenter {
    //MARK:- Variables
    private var viewControllor : MoviesListViewProtocol
    private var movies: [Movie] = []
    private var currentPage = 1
    private var total = 1
    private var totalPages = 1
    private var isFetchInProgress = false
    private let fetchLimit = 20
    private var repo : RepositoryProtocol
    var isDBCalled = false
   
    init(viewController : MoviesListViewProtocol) {
        self.viewControllor = viewController
        repo = RepositoryImp()
    }
    // total count for network or for database
    var totalCount: Int {
             return total
         }
    var currentCount: Int {
        return movies.count
    }
    func movie(at index: Int) -> Movie {
        return movies[index]
    }
    func  resetDefaultsValues() {
        movies.removeAll()
        currentPage = 1
        total = 1
        totalPages = 1
        isDBCalled = false
        isFetchInProgress = false
    }
    //MARK:- Handle Logic
    /**
     
     Getting data from network
     1- first call network
     2- if there is network error:
     i- for the first time , get data from db
     ii-at any time , show no internet connection
     3 - if there is no error , fetch data from network , then save it to db (with no duplication)
     Getting data from db
     1- for the first time , getting data count in db and show no internet
     2- if there is no data in db , show no data
     3- if there is data , show data
     */
    
    func fetchMovies() {
        // 1 if a fetch request is already in progress. This prevents multiple requests happening. More on that later.
        guard !isFetchInProgress else {
            return
        }
        // 2 starting send requests (call from network then save to db)
        isFetchInProgress = true
        //MARK:  request data
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let self = self {
                if self.isDBCalled {
                    self.callDataFromDB()
                }else {
                    self.fetchData()
                }
            }
        }
    }

    //MARK:- Getting data from network
    private  func fetchData()  {
        repo.getDataFromAPI(From: API.BASE_URL+AllMoviesRequest.path, parameters: AllMoviesRequest.parameters, page: self.currentPage) { [weak self] (apiResult : Result<AllMovies, DataResponseError>) in
            if let self = self {
                switch apiResult {
                // 3 If the request fails, call db
                case .failure(let error):
                    switch error {
                    case .network:
                        //when openning, then total count = 1 so we call db
                        if self.total == 1 {
                            self.isDBCalled = true
                            self.callDataFromDB()
                        }else {
                            DispatchQueue.main.async {
                                self.isFetchInProgress = false
                                self.viewControllor.onFetchFailed(with: "no internet connection")
                            }
                        }
                    case .decoding:
                        self.isFetchInProgress = false
                        print("error to decode network data")
                    }
                //4 If the request is successful, save to db and show data
                case .success(let response):
                    self.isFetchInProgress = false
                    self.repo.postDataToLocalDB(With: response.results) { (result : Result<Bool, LocalDataResponseError>) in
                        print( "saving data to db \(result)")
                    }
                    self.total = response.totalResults
                    self.totalPages = response.totalPages
                    self.prepareDataToShow(results: response.results)
                }
            }
        }
    }
    //MARK:- Getting saved data to show
    private func callDataFromDB(){
        // getting count for all saved movies, only one time
        if total == 1 {
            DispatchQueue.main.async {
                     self.viewControllor.onFetchFailed(with: "no internet connection")
            }
            repo.getMoviesCountInLocalDB { [weak self] (result : Result<Int, LocalDataResponseError>) in
                if let self = self {
                    switch result {
                    case .success(let count):
                        self.total = count
                    case .failure(_): break
                    }
                }
            }
        }
        //  getting paging data in db with fetch limit 20
        repo.getDataFromLocalDB(fetchLimit: fetchLimit, fetchOffeset : movies.count) { [weak self] (result: Result<[Movie], LocalDataResponseError>) in
            if let self = self {
                switch result {
                case .success(let moviesDB):
                    if moviesDB.isEmpty {
                        //  if movies is Empty , show no internet connection
                        DispatchQueue.main.async {
                            self.isFetchInProgress = false
                            self.viewControllor.onFetchFailed(with: "empty , no internet")
                            self.viewControllor.showEmptyLocalData()
                        }
                    }else {
                        // show data if there is data in db
                        self.isFetchInProgress = false
                        self.prepareDataToShow(results: moviesDB)
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    //MARK:- prepare showing views
    private func calculateIndexPathsToReload(from newMovies: [Movie]) -> [IndexPath] {
        let startIndex = movies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    private func prepareDataToShow (results : [Movie]){
        DispatchQueue.main.async {
            self.isFetchInProgress = false
            self.movies.append(contentsOf: results)
            //show data in specific rows
            if self.currentPage > 1 {
                // send index paths to table view to reload
                let indexPathsToReload = self.calculateIndexPathsToReload(from: results)
                self.viewControllor.onFetchCompleted(with: indexPathsToReload)
            } else {
                self.viewControllor.onFetchCompleted(with: .none)
            }
            self.currentPage += 1
        }
    }
    
}
