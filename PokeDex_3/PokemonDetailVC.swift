//
//  PokemonDetailVC.swift
//  PokeDex_3
//
//  Created by James Thomson on 22/02/2017.
//  Copyright © 2017 James Thomson. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = pokemon.name
        
    }

}
