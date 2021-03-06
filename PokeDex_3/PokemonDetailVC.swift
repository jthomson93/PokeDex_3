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
    

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalized
        
        pokemon.downloadPokemonDetails { () -> () in
            
            print("Did arrive here")
            self.updateUI()
        }
        
    }

    @IBAction func backButtonPressed(_ sender: Any) { // Back Button
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        attackLabel.text = pokemon.attack
        defenceLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        pokedexLabel.text = "\(pokemon.pokedexID)"
        currentEvoImage.image = UIImage(named: "\(pokemon.pokedexID)")
        mainImage.image = currentEvoImage.image
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        
        if pokemon.nextEvoID == "" || pokemon.nextEvoLevel == "" {
            evoLabel.text = "No Evolutions"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.image = UIImage(named: String(pokemon.nextEvoID))
            nextEvoImage.isHidden = false
            let str = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            evoLabel.text = str
        }
    }
}
