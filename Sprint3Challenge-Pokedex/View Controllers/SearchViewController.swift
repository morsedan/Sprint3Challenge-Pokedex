//
//  SearchViewController.swift
//  Sprint3Challenge-Pokedex
//
//  Created by morse on 6/1/19.
//  Copyright © 2019 morse. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var typesLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var saveButton: UIButton!
    
    // New property to hold references to labels
    var labels: [UIView] = []
    
    var pokemonController: PokemonController?
    var pokemon: Pokemon?
    var searchOff = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        updateViews()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        
        pokemonController?.searchForPokemon(with: searchTerm, completion: { result in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                    self.saveButton.isHidden = false
                }
            }
        })
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = self.pokemon else { return }
        pokemonController?.savePokemon(pokemon)
        self.navigationController?.popViewController(animated: true)
    }
    
    // I tend to pull out one-time setup type things into its own funciton like this. Just so I know where to put all the stuff that I want to happen once, at the beginning.
    private func setupViews() {
        // By the time you get here, these all exist, so you can fill the array with them.
        labels = [nameLabel, imageView, idLabel, typesLabel, abilitiesLabel]
        
        // Start with save button hidden
        saveButton.isHidden = true
        
        // If there is a pokemon right now, it means we were given one by the tableView. So we don't need the search bar, but we should update the title
        if let pokemon = pokemon {
            searchBar.isHidden = true
            title = pokemon.name
        }
        
        searchBar.delegate = self
    }
    
    // I tend to put anything that needs to be update in the state of a view in a function like this. It generally holds all the logic for what needs to be updated based on the model, so that anywhere I need to update the state, I can just call updateViews().
    private func updateViews() {
        updateLabels()
        
        // If there is no pokemon, the rest of this function doesn't need to run.
        guard let pokemon = pokemon else { return }
        
        nameLabel.text = pokemon.name
        idLabel.text = "ID: \(pokemon.id)"
        typesLabel.text = "Types: \(pokemon.typeString)"
        abilitiesLabel.text = "Abilities: \(pokemon.abilityString)"
        loadImage(for: pokemon)
    }
    
    // I renamed this to updateLabels, because it fit what it is doing better, after the changes I made.
    func updateLabels() {
        // If there is no pokemon, we don't want to show the labels
        let status = pokemon == nil
        
        labels.forEach { $0.isHidden = status }
        
    }
    
    // I pulled this out to its own function, partially because of its complexity, and partially because this would make it easier to improve. Say, if you had the image cached somewhere.
    private func loadImage(for pokemon: Pokemon) {
        // Now that we have imageData stored with the Pokemon, we can check for that before making a network call
        if let data = pokemon.imageData {
            imageView.image = UIImage(data: data)
            return
        }
        
        // If we get here, it means we haven't previously stored the data for that pokemon, so we actually need to make the network call.
        pokemonController?.fetchImage(for: pokemon, completion: { result in
            if let data = try? result.get() {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.pokemon?.imageData = data
                    self.imageView.image = image
                }
            }
        })
    }
}

