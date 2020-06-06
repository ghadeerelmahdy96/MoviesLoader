//
//  TableViewCell.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import Foundation
import UIKit
extension UITableViewCell {
    static var identifier: String {
               return String(describing: self)
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    func makeCard(withBorder : Bool) {
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.7
        if withBorder {
            self.layer.borderColor =  UIColor.gray.cgColor
            self.layer.borderWidth = 2.0
        }
    }
    
}
