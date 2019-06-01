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
    
    var pokemonController: PokemonController?

    override func viewDidLoad() {
        super.viewDidLoad()

        hideLabels()
    }
    
    func hideLabels() {
        nameLabel.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
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
