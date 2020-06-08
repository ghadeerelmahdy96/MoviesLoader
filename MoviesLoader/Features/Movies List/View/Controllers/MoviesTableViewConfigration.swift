//
//  MoviesTableView.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import UIKit

extension MoviesListViewController :  UITableViewDelegate , UITableViewDataSource , UITableViewDataSourcePrefetching {
 
    
    //MARK:- Table view Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if presenter != nil{
            count = presenter.totalCount
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as! MovieCell
        if isLoadingCell(for: indexPath) {
             cell.configure(with: .none)
           } else {
            cell.configure(with: presenter.movie(at: indexPath.row))
           }
        return cell
    }
     //MARK:- Table view Data source Prefetching
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
          if indexPaths.contains(where:  isLoadingCell) {
                presenter?.fetchMovies()
          }
      }
      
       //MARK:- Table view Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !isLoadingCell(for: indexPath) {
              self.showMovieDetails(movie: presenter.movie(at: indexPath.row))
        }
      

    }

}
