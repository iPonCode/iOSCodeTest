//  MovieDetailsViewController.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 07/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // TODO: Declare a var for the movie data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // TODO: Function to set movie data
    
    func configureView() {
        view.backgroundColor = .systemBlue
        
        // be sure our movie data var not nil with a guard let
        
        title = "Movie Details"
        print("Movie Details View Loaded.")
        
        // TODO: paint all
    }
}
