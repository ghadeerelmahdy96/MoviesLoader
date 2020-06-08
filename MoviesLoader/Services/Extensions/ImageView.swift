//
//  ImageView.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/8/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    func setImageFromNetwork(posterPath : String)  {
        let imageString = API.IMAGE_BASE_URL + posterPath
        let url = URL.init(string: imageString)
        self.kf.setImage(with: url, placeholder: "Movie Image" as? Placeholder, options: .none, progressBlock: nil) {[weak self] (result ) in
            switch result {
            case .success(_):
                break
            case .failure(_):
                self?.image = UIImage.init(named: "movie.png")
            }
        }
        
    }
    
}
