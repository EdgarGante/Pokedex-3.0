//
//  Pokemon.swift
//  Pokedex
//
//  Created by Edgar on 11/30/16.
//  Copyright © 2016 Edgar Gante. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    init (name: String, pokedexId: Int) {
        self._name = name
        self._pokedexID = pokedexId
    }
    
}
