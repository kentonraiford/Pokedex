//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Kenton D. Raiford on 11/16/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController
{
    @IBOutlet weak var pokemonNameLbl: UILabel!
    
    var pokemon: Pokemon! //We create a variable that the data from the selected collection cell will go into.
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        pokemonNameLbl.text = pokemon.name
    }

}
