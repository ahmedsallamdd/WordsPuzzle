//
//  CountriesModel.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 07/09/2022.
//

import Foundation

// MARK: - CountriesModel
struct CountriesModel: Codable {
    let countries: [Country]
}

// MARK: - Country
struct Country: Codable {
    let name, capital: String
}

