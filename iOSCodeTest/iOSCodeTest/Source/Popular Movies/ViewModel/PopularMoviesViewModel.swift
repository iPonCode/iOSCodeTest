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
    func retrievePopularMovies()
}

// Here all business logic
class PopularMoviesViewModelImpl: PopularMoviesViewModel {
    
    var movies: [PopularMovie] = []
    
    // The Webservice call
    func retrievePopularMovies() {
        print("retrieving popular movies from Webservice..")
        
        let baseUrl = "https://api.themoviedb.org/3/movie/popular"
        let apiKey = "72528dfa50871fd94e3094b9d73cd3be"
        // Options parameters
        let language = "es-ES"  //ISO 639-1 value to display translated data for supported fields
        let page = "1"          //from 1 to 1000
        let region = "ES"       //ISO 3166-1 code to filter release dates, uppercase
        
        let url = baseUrl + "?api_key=" + apiKey + "&language=" + language + "&page=" + page + "&region=" + region
        AF.request(url).responseJSON {[weak self] response in
            
            guard let serverData = response.data, let popularMovies = try? JSONDecoder().decode(PopularMovies.self, from: serverData) else {
                print("Error decoding server response")
                return
            }
            
            self?.movies = popularMovies.results
            print(self?.movies ?? "NO MOVIES")
        }
    }
        
}
