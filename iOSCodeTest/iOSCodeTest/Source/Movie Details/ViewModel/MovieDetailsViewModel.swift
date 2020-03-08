//  MovieDetailsViewModel.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 08/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import Alamofire

// With this protocol we can change current ViewModel implementation for another one without change any other thing
protocol MovieDetailsViewModel {
    func retrieveMovieDetails()
}

// Here all business logic
class MovieDetailsViewModelImpl: MovieDetailsViewModel {
    
    var details: MovieDetails = MovieDetails()
    
    // The Webservice call
    func retrieveMovieDetails() {

        print("retrieving movie detail from Webservice..")
        
        let baseUrl = "https://api.themoviedb.org/3/movie/"
        let apiKey = "72528dfa50871fd94e3094b9d73cd3be"
        // Options parameters
        let language = "es-ES"              //ISO 639-1 value to display translated data for supported fields
        //let append_to_response = "images" //feature to append request with the same namespace to response (videos,images)
        let mockMovieID = "475303"
        
        let url = baseUrl + mockMovieID + "?api_key=" + apiKey + "&language=" + language //+ "&append_to_response=" + append_to_response
        AF.request(url).responseJSON {[weak self] response in
            
            guard let serverData = response.data, let movieDetails = try? JSONDecoder().decode(MovieDetails.self, from: serverData) else {
                print("Error decoding server response")
                return
            }
            
            self?.details = movieDetails
            print(self?.details ?? "NO MOVIE DETAILS")
        }
    }
    
}
