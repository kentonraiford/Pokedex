//
//  CollectionViewCell.swift
//  Pokedex
//
//  Created by Kenton D. Raiford on 11/15/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class PokeViewCell: UICollectionViewCell
{
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) //Configure and update the content of each cell.
    {
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
