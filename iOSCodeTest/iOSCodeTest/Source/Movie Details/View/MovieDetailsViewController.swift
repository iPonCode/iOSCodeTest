//  MovieDetailsViewController.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 07/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // TODO: Declare a var for the movie data
    
    var viewModel: MovieDetailsViewModel = MovieDetailsViewModelImpl()
    var details: MovieDetails?
    var movieID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
        retrieveMovieDetails()
    }
    
    // TODO: Function to set movie data
    
    func configureView() {
        view.backgroundColor = .systemBlue
        
        // be sure our movie data var not nil with a guard let
        
        title = "Movie Details"
        
        // TODO: paint all
    }
    
    // Create binders
    func bindViewModel() {
        
        // Start listening to this var
        viewModel.details.bind({ [weak self] (result) in
            guard let result = result else {
                return
            }
            // Whenever chages are made on int, will execute this code
            self?.details = result
            dump(self?.details)
            // TODO: reload data
        })
        
    }
    
    func retrieveMovieDetails() {
        if let movieID = movieID {
            print(movieID)
            viewModel.retrieveMovieDetails(movieID)
        }
    }
    
    func setMovieId(_ id: Int) {
        movieID = id
    }
}
