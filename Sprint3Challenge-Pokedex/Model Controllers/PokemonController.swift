//
//  PokemonController.swift
//  Sprint3Challenge-Pokedex
//
//  Created by morse on 6/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badData
    case noDecode
    case otherError
}

class PokemonController {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    var pokemons:  [Pokemon] = []
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Result<[Pokemon], NetworkError>) -> ()) {
        
        let pokemonURL = baseURL.appendingPathComponent(searchTerm)
        
        var request = URLRequest.init(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemons = try decoder.decode([Pokemon].self, from: data)
                completion(.success(pokemons))
            } catch {
                NSLog("Error decoding pokemon object: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func savePokemon() {
        
    }
    
    func fetchImage() {
        
    }
    
    
    
    
}
