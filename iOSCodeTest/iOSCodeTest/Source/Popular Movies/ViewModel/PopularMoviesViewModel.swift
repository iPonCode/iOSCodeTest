//  PopularMoviesViewModel.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 07/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import Alamofire

// With this protocol we can change current ViewModel implementation for another one without change any other thing
protocol PopularMoviesViewModel {
    var movies: Observable<[PopularMovie]> {get}
    func retrievePopularMovies()
    func buildImagedUrl(_ path: String?) -> String?
    func searchText(_ text: String)
}

// Here all business logic
class PopularMoviesViewModelImpl: PopularMoviesViewModel {

    var movies = Observable<[PopularMovie]>([], thread: .main)
    var localMovies: [PopularMovie] = []
    
    private var filterText: String = "" {
        didSet {
            updateMoviesWithFilter()
        }
    }

    // The Webservice call
    // TODO: Load more results and append to localMovies array that was previously loaded,
    //       perhaps, can use the bar button to load more results instead to refresh.
    //       Will need to control webservice page when build the url to request
    
    func retrievePopularMovies() {
        
        print("retrieving popular movies from Webservice..")
        
        let url = buildPopularMoviesUrl()
        AF.request(url).responseJSON {[weak self] response in
            
            guard let serverData = response.data, let popularMovies = try? JSONDecoder().decode(PopularMovies.self, from: serverData) else {
                print("Error decoding server response")
                return
            }
            
            self?.localMovies = popularMovies.results // Save data received from webservice

            // Set movies data that will be binded taking account of whether current filter
            self?.updateMoviesWithFilter()
            
            }
        }
    
    func updateMoviesWithFilter () {
        
        // TODO: Search in more fields than titles, perhaps overviews
        self.movies.value = !filterText.isEmpty ?
            self.localMovies.filter({ $0.title.lowercased().contains(filterText.lowercased()) }) :
            self.localMovies
    }
    
    func buildPopularMoviesUrl() -> String {
        
        // TODO: put all this info like apiKey, etc.. in a static let Constants sturct
        let baseUrl = "https://api.themoviedb.org/3/movie/popular"
        let apiKey = "72528dfa50871fd94e3094b9d73cd3be"
        
        // Optionals parameters
        let language = "es-ES"  //ISO 639-1 value to display translated data for supported fields
        let page = "7"        //from 1 to 500, 20 results per page, total 10000 results
        let region = "ES"       //ISO 3166-1 code to filter release dates, uppercase
        
        return baseUrl + "?api_key=" + apiKey + "&language=" + language + "&page=" + page + "&region=" + region
    }
    
    func buildImagedUrl(_ path: String?) -> String? {
        
        guard let path = path else {
            return nil
        }
        
        // path includes the / like this: /ya9ojfuWylP4P6iiaIaxz67Chu0.jpg
        // TODO: Get this configuration from webservice and cache it
        let baseUrl = "https://image.tmdb.org/t/p/"
        let posterSize = "w92" // TODO: Create enum with all sizes and pass through as a parameter
        
        return baseUrl + posterSize + path
    }
    
    func searchText(_ text: String) {
        filterText = text
    }
        
}
