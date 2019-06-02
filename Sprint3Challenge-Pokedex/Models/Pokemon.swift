//
//  Pokemon.swift
//  Sprint3Challenge-Pokedex
//
//  Created by morse on 6/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Hashable {
    var name: String
    let id: Int
    let abilities: [Ability]
    let types: [TypeObject]
    let sprites: Sprite

    // Add a variable to hold the image data once the sprite is fetched
    var imageData: Data?
    
    
    // I added these two computed properties to the Pokemon type, so that you can just do this formatting in one place, but you get the strings anywhere you have a Pokemon.
    var abilityString: String {
        let array = abilities.map { $0.ability.name.capitalized }
        return array.joined(separator: ", ")
    }
    
    var typeString: String {
        let array = types.map { $0.type.name.capitalized }
        return array.joined(separator: ", ")
    }
    
    
}

struct Ability: Codable, Hashable {
    let ability: AbilityCharacteristic
}

struct AbilityCharacteristic: Codable, Hashable {
    let name: String
}

struct TypeObject: Codable, Hashable {
    let type: TypeCharacteristic
}

struct TypeCharacteristic: Codable, Hashable {
    let name: String
}

struct Sprite: Codable, Hashable {
    let frontShiny: String
}
