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
    private var _nextEvoName: String!
    private var _nextEvoID: String!
    private var _nextEvoLevel: String!
    private var _pokemonURL: String!
    
    
    
//Getter and Setter with nil protection
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoID: String {
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
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
    
    
    func downloadPokemonDetails(completed: @escaping  DownloadComplete) {
        
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
            
            if let types = dict?["types"] as? [Dictionary<String, AnyObject>], types.count > 0 {
                
                if let name = types[0]["name"] {
                    
                    self._type = name.capitalized
                }
                
                if types.count > 1 { // If there is more than one dictionary within the 'types' array this will add them to the text.
                    
                    for x in 1..<types.count {
                        
                        if let name =  types[x]["name"] {
                            self._type! += "/\(name.capitalized!)"
                        }
                    }
                }
            }
            
            if let descArr = dict?["descriptions"] as? [Dictionary <String, String>], descArr.count > 0 {
                
                if let url = descArr[0]["resource_uri"] {
                    
                    let descriptionURL = "\(URL_BASE)\(url)"
                    
                    Alamofire.request(descriptionURL).responseJSON { (response) in
                        
                        if let descDict = response.value as? Dictionary<String, AnyObject> {
                            
                            if let desApi = descDict["description"] as? String {
                                
                                self._description = desApi
                                print(self.description)
                                
                            }
                            
                        }
                        completed()
                    }
                }
                
            }
            
            if let evolutions = dict?["evolutions"] as? [Dictionary <String, AnyObject>], evolutions.count > 0 {
                
                if let nextEvo = evolutions[0]["to"] as? String {
                    
                    if nextEvo.range(of: "mega") == nil {
                        
                        self._nextEvoName = nextEvo
                        
                    } else {
                        self._nextEvoID = ""
                    }
                }
                
                if let uri = evolutions[0]["resource_uri"] as? String {
                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                    let nextEvolutionId = newStr.replacingOccurrences(of: "/", with: "")
                    self._nextEvoID = nextEvolutionId
                }
                
                if let lvlExists = evolutions[0]["level"] {
                    if let lvl = lvlExists as? Int {
                        self._nextEvoLevel = "\(lvl)"
                    } else {
                        self._nextEvoLevel = ""
                    }
                }
            }
            completed()
            }
        
          
        }
        
    

        
}
    
    
