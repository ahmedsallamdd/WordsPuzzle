//
//  MoviesModel.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 04/09/2022.
//

import Foundation

// MARK: - MoviesModel
struct MoviesModel: Codable {
    let genres: [String]
    let movies: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let title, year, runtime: String
    let genres: [String]
    let director, actors, plot: String
    let posterURL: String

    enum CodingKeys: String, CodingKey {
        case id, title, year, runtime, genres, director, actors, plot
        case posterURL = "posterUrl"
    }
}
