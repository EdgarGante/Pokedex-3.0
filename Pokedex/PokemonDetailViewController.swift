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
    
    @IBOutlet weak var bckBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolutionInformationLabel: UILabel!
    @IBOutlet weak var currentEvolution: UIImageView!
    @IBOutlet weak var nextEvolution: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalized

        
        let img = UIImage(named: "\(pokemon.pokedexID)")
        pokemonImage.image = img
        currentEvolution.image = img
        pokemonIdLabel.text = "\(pokemon.pokedexID)"
        
        bckBtn.isEnabled = true
        bckBtn.isUserInteractionEnabled = true
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        descriptionLabel.text = pokemon.pokeDescription
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        
        if pokemon.nextEvolutionId == "" {
            evolutionInformationLabel.text = "No Evolutions"
            nextEvolution.isHidden = true
        } else {
            
            nextEvolution.isHidden = false
            nextEvolution.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evolutionInformationLabel.text = str
            

        }
        
        
    }
    
}
