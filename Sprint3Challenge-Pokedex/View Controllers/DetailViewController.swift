//
//  DetailViewController.swift
//  Sprint3Challenge-Pokedex
//
//  Created by morse on 6/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        displayPokemon()
    }
    
    func displayPokemon() {
        guard let pokemon = self.pokemon else { return }
        var typeArray: [String] = []
        var abilitiesArray: [String] = []
        for item in pokemon.types {
            typeArray.append(item.type.name)
        }
        for item in pokemon.abilities {
            abilitiesArray.append(item.ability.name)
        }
        
        self.navigationItem.title = pokemon.name
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = typeArray.joined(separator: ", ")
        abilitiesLabel.text = abilitiesArray.joined(separator: ", ")
        pokemonController?.fetchImage(at: pokemon.sprites.frontShiny, completion: { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
