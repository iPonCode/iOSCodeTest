//  PopularMoviesViewController.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 07/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    static let MovieCellIdAndNibName = "PopularMovieCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: PopularMoviesViewModel = PopularMoviesViewModelImpl()
    var movies: [PopularMovie] = [PopularMovie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
        retrievePopularMovies()
    }

    func configureView() {
        
        // Register cell
        tableView.register(UINib(nibName: "PopularMovieCell", bundle: nil), forCellReuseIdentifier: PopularMoviesViewController.MovieCellIdAndNibName)
        
        // Configure searchBar
        searchBar.barStyle = .default
        searchBar.showsCancelButton = false
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(retrievePopularMovies))
        navigationItem.setRightBarButton(refreshButton, animated: true)

        //navigationItem.title = "Cargando.."
        title = "Cargando.."
    }
    
    // Create binders
    func bindViewModel() {
        
        // Start listening to this var
        viewModel.movies.bind({ [weak self] (result) in
            guard let result = result else {
                return
            }
            
            // Whenever chages are made on int, will execute this code
            self?.movies = result
            dump(self?.movies)
            self?.updateTitle()
            self?.tableView.reloadData()
        })
        
    }
    
    @objc func retrievePopularMovies() {
        //navigationItem.title = "Cargando.."
        title = "Cargando.."
        viewModel.retrievePopularMovies()
    }
    
    func updateTitle() {
        //navigationItem.title = "Películas populares"
        title = String(format: "Películas populares (%d)", movies.count)
    }
    
    func viewMovieDetails(_ id: Int) {
        guard let detailMovieViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        // TODO: pass through the movie.id
        detailMovieViewController.setMovieId(id)
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
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PopularMoviesViewController.MovieCellIdAndNibName, for: indexPath) as? PopularMovieCellImpl {
        
            let movie = movies[indexPath.row]
            let url = viewModel.buildImagedUrl(movie.posterPath)
            cell.configure(id: movie.id, title: movie.title, posterUrl: url, releaseDate: movie.releaseDate, overview: movie.overview)
            //cell.delegate = self // TODO: protocol for cell actions
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
        let movieId = movies[indexPath.row].id
        searchBar.resignFirstResponder()
        viewMovieDetails(movieId)
    }
}

// MARK: - Methods of UISearchBarDelegate

extension PopularMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText(searchText)
     }
    
}
