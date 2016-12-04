//
//  ViewController.swift
//  Pokedex
//
//  Created by Edgar on 11/30/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var userIsInSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parsePokemonCSV()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self

        // Dissmis keyboard when tapped around
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        searchBar.setTextColor(color: .white)
        searchBar.returnKeyType = .search
        searchBar.keyboardAppearance = .dark
    
    }
    
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokemonCollectionViewCell {
            
            let  poke: Pokemon!
            
            if userIsInSearchMode {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
            } else {
                poke = pokemon[indexPath.row]
                cell.configureCell(poke)
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        
        if userIsInSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailIdentifier", sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if userIsInSearchMode {
            return filteredPokemon.count
        } else {
        return pokemon.count

        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            userIsInSearchMode = false
            collection.reloadData()
            dismissKeyboard()
            
        } else {
            userIsInSearchMode =  true
    
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailIdentifier" {
            if let detailVC = segue.destination as? PokemonDetailViewController {
                if let poke = sender as? Pokemon {
                    detailVC.pokemon = poke
                }
            }
        }
    }

}

