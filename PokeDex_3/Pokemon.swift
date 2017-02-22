//
//  Pokemon.swift
//  PokeDex_3
//
//  Created by James Thomson on 17/02/2017.
//  Copyright © 2017 James Thomson. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _pokemonURL: String!
    
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
    
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
            _nextEvoTxt = ""
        }
        return _nextEvoTxt
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
    
//Initialiser
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        self._pokemonURL = "\(URL_BASE)\(URL_POKE)\(self.pokedexID)/"
    }
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            let dict = response.result.value as? Dictionary<String, AnyObject>
            
            if let weight = dict?["weight"] as? String {
                
                self._weight = weight
            }
            
            if let height = dict?["height"] as? String {
                
                self._height = height
            }
            
            if let attack = dict?["attack"] as? Int {
                
                self._attack = "\(attack)"
            }
            
            if let defense = dict?["defense"] as? Int {
                
                self._defense = "\(defense)"
            }
            
        }
        
        completed()
    }
    

}
    
    
