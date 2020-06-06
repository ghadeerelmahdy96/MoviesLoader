//
//  MoviesListViewController.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import UIKit
import Toast_Swift
class MoviesListViewController: BaseViewController , MoviesListViewProtocol {

    
//MARK:- Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var moviesTableView: UITableView!
//MARK:- Variables
     var presenter : MoviesListPresenter!
//MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesListPresenter(viewController: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         setupViews()
         presenter?.fetchMovies()
    }
 //MARK:-  MoviesListViewProtocol
    func onFetchFailed(with reason: String) {
        //fetch data from local db
        //show toast
        var style = ToastStyle()
        style.messageColor = ColorPalette.RWYellow
        self.view.makeToast("No Internet Connection", position: .bottom, style: style)
             activityIndicator.stopAnimating()
        
//             let title = "Warning".localizedString
//             let action = UIAlertAction(title: "OK".localizedString, style: .default)
//             displayAlert(with: title , message: reason, actions: [action])
    }
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
           guard let newIndexPathsToReload = newIndexPathsToReload else {
                activityIndicator.stopAnimating()
                moviesTableView.isHidden = false
                moviesTableView.reloadData()
                return
              }
              let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
              moviesTableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
       
    
//MARK:- Methods
   private func setupViews()  {
           //activity indicator
           activityIndicator.hidesWhenStopped = true
           activityIndicator.color = ColorPalette.RWYellow
           activityIndicator.startAnimating()
           //table view
           moviesTableView.isHidden = true
           moviesTableView.separatorColor = ColorPalette.RWYellow
           moviesTableView.dataSource = self
           moviesTableView.prefetchDataSource = self
           moviesTableView.delegate = self
           moviesTableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
    }
    
      func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= presenter.currentCount 
      }
      
      func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = moviesTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
      }
}

