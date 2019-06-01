//
//  File.swift
//  Sprint3Challenge-Pokedex
//
//  Created by morse on 6/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case get = "GET"
}

enum NetworkError: Error {
    case badData
    case noDecode
}

class PokemonController {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokemons:  [Pokemon] = []
    
    func searchForPokemon(with searchTerm: String, completion: @escaping () -> ()) {
        
//        let pokemonURL =
    }
    
    func savePokemon() {
        
    }
    
    func fetchImage() {
        
    }
    
    
    
    
}
