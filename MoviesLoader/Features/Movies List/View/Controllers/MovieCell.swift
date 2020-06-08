//
//  MovieCell.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/4/20.
//  Copyright © 2020 iti. All rights reserved.
//

import UIKit
import Kingfisher
@IBDesignable
class MovieCell: UITableViewCell {
//MARK:- outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var activityIndicatorCell: UIActivityIndicatorView!
//MARK:- cell setup
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicatorCell.hidesWhenStopped = true
        activityIndicatorCell.color = ColorPalette.RWYellow
        // self.makeCard(withBorder: true)
    }
    
    func configure(with movie: Movie?) {
        if let movie = movie {
            dataView.alpha = 1
            movieTitle.text = movie.title
            movieRate.text = "\(movie.voteAverage!)"
            releaseDate.text = movie.releaseDate
            if let posterPath = movie.posterPath
            {
                movieImage.setImageFromNetwork(posterPath: posterPath)
            }else {
                movieImage.image = UIImage.init(named: "movie.png")
            }
            activityIndicatorCell.stopAnimating()
        } else {
            dataView.alpha = 0
            activityIndicatorCell.startAnimating()
        }
    }
    
}
