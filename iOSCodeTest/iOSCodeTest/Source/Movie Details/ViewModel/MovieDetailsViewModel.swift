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
    var details: Observable<MovieDetails> {get}
    func retrieveMovieDetails(_ id: Int)
    func buildImagedUrl(_ path: String?) -> String?
}

// Here all business logic
class MovieDetailsViewModelImpl: MovieDetailsViewModel {
    
    var details = Observable<MovieDetails>(nil, thread: .main)

    // The Webservice call
    func retrieveMovieDetails(_ id: Int) {

        print("retrieving movie detail from Webservice..")
        
        let url = buildMovieDetailsUrl(id)
        AF.request(url).responseJSON {[weak self] response in
            
            guard let serverData = response.data, let movieDetails = try? JSONDecoder().decode(MovieDetails.self, from: serverData) else {
                print("Error decoding server response")
                return
            }
            
            self?.details.value = movieDetails
            //print(self?.details.value ?? "NO MOVIE DETAILS")
        }
    }
    
    func buildMovieDetailsUrl(_ id: Int) -> String {

        // TODO: put all this info like apiKey in a Constant sturct
        let baseUrl = "https://api.themoviedb.org/3/movie/"
        let apiKey = "72528dfa50871fd94e3094b9d73cd3be"
        
        // Options parameters
        let language = "es-ES"              //ISO 639-1 value to display translated data for supported fields
        //let append_to_response = "images" //feature to append request with the same namespace to response (videos,images)
        
        return baseUrl + String(id) + "?api_key=" + apiKey + "&language=" + language //+ "&append_to_response=" + append_to_response

    }
    
    func buildImagedUrl(_ path: String?) -> String? {
        
        guard let path = path else {
            return nil
        }
        
        // path includes the / like this: /ya9ojfuWylP4P6iiaIaxz67Chu0.jpg
        // TODO: get this configuration from webservice and cache
        let baseUrl = "https://image.tmdb.org/t/p/"
        let posterSize = "w154" // TODO: Create enum with all sizes and pass through as a parameter
        
        return baseUrl + posterSize + path
    }
        
}
