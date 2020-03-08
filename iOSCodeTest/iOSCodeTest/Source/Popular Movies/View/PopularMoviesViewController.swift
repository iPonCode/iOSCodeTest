//  PopularMoviesViewController.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 07/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    // TODO: IBOulet UITableView or UIStackView
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PopularMoviesViewModel = PopularMoviesViewModelImpl()
    // TODO: Declare an PopularMovies Array

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
        retrievePopularMovies()
    }

    func configureView() {
        
        // temporal button to show the Movie detail ViewController
        let detailButton = UIBarButtonItem(title: "Detail", style: .done, target: self, action: #selector(viewMovieDetail))
        navigationItem.setRightBarButton(detailButton, animated: true)

        
        // register cell, set title and paint all others visual items
        navigationItem.title = "Popular Movies"
    }
    
    // Create binders
    func bindViewModel() {
        
    }
    
    func retrievePopularMovies() {
        viewModel.retrievePopularMovies()
    }
    
    // TODO: pass movie detail data (and remove @obj)
    @objc func viewMovieDetail() {
        guard let detailMovieViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        //detailMovieViewController.setMovie() // pass the data movie selected here
        //self.present(detailMovieViewController, animated: true, completion: nil)
        navigationController?.pushViewController(detailMovieViewController, animated: true)
    }
}

// TODO: extensions with UITableViewDataSource and UITableViewDelegate protocols methods
