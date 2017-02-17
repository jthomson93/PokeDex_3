//
//  Pokemon.swift
//  PokeDex_3
//
//  Created by James Thomson on 17/02/2017.
//  Copyright © 2017 James Thomson. All rights reserved.
//

import Foundation


class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
//Getter and Setter with nil protection
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
        }
    
    var pokedexID: Int {
        if _pokedexID == nil {
            _pokedexID = 0
        }
        return _pokedexID
    }
    
//Initialiser
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
    
    

}
    
    
