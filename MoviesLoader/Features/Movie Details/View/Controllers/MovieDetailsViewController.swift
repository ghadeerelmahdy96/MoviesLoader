//
//  MovieDetailsViewController.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/6/20.
//  Copyright © 2020 iti. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UITableViewController, MovieDetailsProtocol {
  
    //MARK:- Outlets
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var moviePopularityLbl: UILabel!
     var movie:Movie!
     var presenter : MovieDetailsPresenter!
//MARK:-Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         presenter = MovieDetailsPresenter(movie:  movie, viewController: self)
    }
  //MARK:- Movie Details protocol
    func showData(movie:Movie) {
        languageLbl.text = movie.originalLanguage
        releaseDateLbl.text = movie.releaseDate
        if let posterPath = movie.posterPath
        {
            movieImage.setImageFromNetwork(posterPath: posterPath)
        }else {
            movieImage.image = UIImage.init(named: "movie.png")
        }
        moviePopularityLbl.text = "\(movie.popularity ?? 0)"
        if  movie.overview != "" {
             overviewLbl.text = movie.overview
        }
       
    }
    

}
