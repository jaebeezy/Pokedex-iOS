//
//  PokemonList.swift
//  Pokedex
//
//  Created by Jae Young Choi on 3/1/22.
//

import Foundation

struct PokemonList: Codable {
    let name: String?
    let url: String?
}

struct Response: Codable {
    let count: Int?
    let results: [PokemonList]
}
