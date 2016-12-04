//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Edgar on 12/3/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name
    }
}
