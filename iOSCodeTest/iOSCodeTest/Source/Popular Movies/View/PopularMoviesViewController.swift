//  PopularMoviesViewController.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 07/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PopularMoviesViewModel = PopularMoviesViewModelImpl()
    var movies: [PopularMovie] = [PopularMovie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
        retrievePopularMovies()
    }

    func configureView() {
        
        // temporal button to show the Movie detail ViewController
        let detailButton = UIBarButtonItem(title: "Detail", style: .done, target: self, action: #selector(viewMovieDetails))
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
    @objc func viewMovieDetails() {
        guard let detailMovieViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        //detailMovieViewController.setMovie() // pass the data movie selected here
        //self.present(detailMovieViewController, animated: true, completion: nil)
        navigationController?.pushViewController(detailMovieViewController, animated: true)
    }
}

// MARK: - Methods of UITableViewDataSource protocol

extension PopularMoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154 // poster image 92x138, spacing 8, 138+8+8=154
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20 //TODO: with movies.count (number recieved from webservice)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // TODO: create a static let with PopularMovieCellIdentifier
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieCell", for: indexPath) as? PopularMovieCellImpl {
        
            let movie = movies[indexPath.row]
            cell.configure(id: movie.id, title: movie.title, posterPath: movie.posterPath, releaseDate: movie.releaseDate)
            //cell.delegate = self // TODO: for protocol for actions
            cell.tag = indexPath.row
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - Methods of UITableViewDelegate protocol

extension PopularMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let movieId = movies[indexPath.row].id
        viewMovieDetails() // TODO: pass through the movie.id
    }
}
