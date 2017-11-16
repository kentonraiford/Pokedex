//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kenton D. Raiford on 11/13/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import Foundation


class Pokemon
{
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String
    {
        return _name
    }
    
    var pokedexId: Int
    {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int)
    {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
