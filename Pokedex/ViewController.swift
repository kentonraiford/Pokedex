//
//  ViewController.swift
//  Pokedex
//
//  Created by Kenton D. Raiford on 10/16/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]() //Create an array of pokemon

    override func viewDidLoad()
    {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        
        parsePokemonCSV()
    }

    func parsePokemonCSV() //Parse the pokemon Csv data and put it into a form that we can use
    {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")! //Get the path to the CSV file
        
        do
        {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows
            {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                
                pokemon.append(poke)
            }
            
        }
        catch let error as NSError
        {
            print(error.debugDescription)
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell //Where we create our cell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeViewCell", for: indexPath) as? PokeViewCell
        {
            //let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row)
            
            let poke = pokemon[indexPath.row]
            //cell.configureCell(pokemon: pokemon)
            
            cell.configureCell(pokemon: poke)
            
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) //When you select the object it does something.
    {
        return
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 105, height: 105)
    }
}

