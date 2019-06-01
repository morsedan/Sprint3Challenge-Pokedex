//
//  Pokemon.swift
//  Sprint3Challenge-Pokedex
//
//  Created by morse on 6/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Hashable {
    let name: String
    let id: Int
    let abilities: [Ability]
    let types: [TypeObject]
//    let sprites: [Sprite]
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
    let frontShiney: URL
}
