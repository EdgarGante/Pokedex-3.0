//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Edgar on 11/30/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        pokemonName.text = self.pokemon.name
        pokemonImage.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
    
}
