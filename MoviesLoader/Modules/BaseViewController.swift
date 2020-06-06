//
//  BaseViewController.swift
//  MoviesLoader
//
//  Created by Ghadeer El-Mahdy on 6/5/20.
//  Copyright © 2020 iti. All rights reserved.
//

import UIKit
import Reachability
class BaseViewController: UIViewController ,ReachabilityObserverDelegate , AlertDisplayer{
    
//MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
       try? addReachabilityObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         removeReachabilityObserver()
    }
//MARK:- ReachabilityObserverDelegate
   func reachabilityChanged(_ isReachable: Bool) {
                 if !isReachable {
                     print("No internet connection")
                    //show no internet
                 }else {
                    print("connected")
                 }
         }
    func showNoInternetConnection () {
        
    }
        
}
