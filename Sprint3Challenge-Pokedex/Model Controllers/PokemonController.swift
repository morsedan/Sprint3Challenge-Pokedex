//
//  PokemonController.swift
//  Sprint3Challenge-Pokedex
//
//  Created by morse on 6/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation
import UIKit

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
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> ()) {
        let pokemonURL = baseURL.appendingPathComponent("\(searchTerm.lowercased())/")
        
        var request = URLRequest.init(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        print(request)
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
                let pokemons = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemons))
            } catch {
                NSLog("Error decoding pokemon object: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func savePokemon(_ pokemon: Pokemon) {
        if pokemons.contains(pokemon) {
            return
        }
        pokemons.append(pokemon)
        pokemons.sort { $0.name < $1.name}
    }
    
    func fetchImage(at URLString: String, completion: @escaping (Result<UIImage, NetworkError>) -> ()) {
        
        let imageURL = URL(string: URLString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
}
