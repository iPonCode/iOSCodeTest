//  ModelMovieDetails.swift
//  iOSCodeTest
//
//  Created by Simón Aparicio on 08/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// MARK: - MovieDetails
struct MovieDetails: Codable {
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init() {
        self.adult = false
        self.backdropPath = nil
        self.belongsToCollection = nil
        self.budget = 0
        self.genres = []
        self.homepage = ""
        self.id = 0
        self.imdbID = ""
        self.originalLanguage = ""
        self.originalTitle = ""
        self.overview = ""
        self.popularity = 0.0
        self.posterPath = nil
        self.productionCompanies = []
        self.productionCountries = []
        self.releaseDate = ""
        self.revenue = 0
        self.runtime = 0
        self.spokenLanguages = []
        self.status = ""
        self.tagline = ""
        self.title = ""
        self.video = false
        self.voteAverage = 0.0
        self.voteCount = 0
    }

}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}