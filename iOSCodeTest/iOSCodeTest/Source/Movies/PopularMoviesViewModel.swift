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
    
    // The Webservice call
    func retrievePopularMovies() {
        print("retrieving popular movies from Webservice..")
    }
    
}
