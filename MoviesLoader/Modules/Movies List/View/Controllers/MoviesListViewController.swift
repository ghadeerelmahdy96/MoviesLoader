//
//  MoviesListViewController.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import UIKit
import Toast_Swift
class MoviesListViewController: UIViewController , MoviesListViewProtocol {
    
//MARK:- Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var moviesTableView: UITableView!
    
    @IBOutlet weak var retryOutlet: UIButton!
    
    @IBOutlet weak var noInternetView: UIView!
    
    @IBOutlet weak var noDataFoundImage: UIImageView!
    //MARK:- Variables
     var presenter : MoviesListPresenter!
    
  //MARK:- Actions
    @IBAction func retryButton(_ sender: Any) {
        moviesTableView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        presenter.resetDefaultsValues()
        presenter.fetchMovies()
        noInternetView.isHidden = true
    }

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesListPresenter(viewController: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        noInternetView.isHidden = true
        presenter?.fetchMovies()
    }
    //MARK:-  MoviesListViewProtocol
    func onFetchFailed(with reason: String) {
        noInternetView.isHidden = false
        activityIndicator.stopAnimating()
    }
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        noInternetView.isHidden = !presenter.isDBCalled
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            activityIndicator.stopAnimating()
            noDataFoundImage.isHidden = true
            moviesTableView.isHidden = false
            moviesTableView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        moviesTableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    func showEmptyLocalData() {
        noDataFoundImage.isHidden = false
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




