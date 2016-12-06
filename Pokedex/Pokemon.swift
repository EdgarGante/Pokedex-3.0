//
//  Pokemon.swift
//  Pokedex
//
//  Created by Edgar on 11/30/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTitle: String!
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    var nextEvolutionTitle: String {
        
        if _nextEvolutionTitle == nil {
            _nextEvolutionTitle = ""
        }
        
        return _nextEvolutionTitle
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        
        return _attack
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    init (name: String, pokedexId: Int) {
        self._name = name
        self._pokedexID = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
    Alamofire.request(_pokemonURL).responseJSON { (response) in
        
        if let dict = response.result.value as? Dictionary<String, AnyObject> {
          
            if let weight = dict["weight"] as? String {
                self._weight = weight
            }
            
            if let height = dict["height"] as? String {
                self._height = height
            }
            
            
            if let defense = dict["defense"] as? Int {
                self._defense = "\(defense)"
            }
            
            if let attack = dict["attack"] as? Int {
                self._attack = "\(attack)"
            }
            
            if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                
                if let name = types[0]["name"] {
                    self._type = name.capitalized
                }
                
                if types.count > 1 {
                    for x in 1..<types.count {
                        if let name = types[x]["name"] {
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                }
                
            } else {
                self._type = ""
            }
            
            if let descriptionArray = dict["description"] as? [Dictionary<String, String>] , descriptionArray.count > 0 {
                if let url = descriptionArray[0]["resource_uri"] {
                    
                    let descriptionURL = "\(URL_BASE)\(url)"
                    
                    Alamofire.request(descriptionURL).responseJSON(completionHandler: { (response) in
                        if let descriptionDictionary = response.result.value as? Dictionary<String, AnyObject> {
                            if let pokeDescription = descriptionDictionary["description"] as? String {
                                
                                let newDescription = pokeDescription.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                print(newDescription)
                            }
                        }
                    })
                }
            }
            
            }
        
        completed()
        
        }
    
    }
}
