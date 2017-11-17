//
//  ViewController.swift
//  Pokedex
//
//  Created by Kenton D. Raiford on 10/16/17.
//  Copyright © 2017 Kenton D. Raiford. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate
{
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]() //Create an array of pokemon
    var filteredPokemon = [Pokemon]() //This is where we will store the filtered pokemon from the list.
    var inSearchMode = false //A boolean to tell us whether we are in search mode or not.
    var musicPlayer: AVAudioPlayer!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() //Get the audio ready
    {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do
        {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1 //Continuously
            musicPlayer.play()
        }
        catch let error as NSError
        {
            print(error.debugDescription)
        }
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
            
            //let poke = pokemon[indexPath.row]
            //cell.configureCell(pokemon: pokemon)
            
            let poke: Pokemon!
            
            if inSearchMode
            {
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            else
            {
                poke = pokemon[indexPath.row]
                cell.configureCell(pokemon: poke)
            }
            
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) //When you select the object it does something.
    {
        var poke: Pokemon!
        
        if inSearchMode
        {
            poke = filteredPokemon[indexPath.row]
        }
        else
        {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) //Happens before the segue occurs to pass data between view controller.
    {
        if let detailsVC = segue.destination as? PokemonDetailVC
        {
            if let poke = sender as? Pokemon //We are saying poke is the sender and it is of class Pokemon.
            {
                detailsVC.pokemon = poke //We set the variable we created in PokemonDetailVC to this view controller's variable poke.
            }
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        if inSearchMode
        {
            return filteredPokemon.count
        }
        
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
    

    
    @IBAction func musicBtnWasPressed(_ sender: UIButton)
    {
        if musicPlayer.isPlaying
        {
            musicPlayer.pause()
            sender.alpha = 0.2
        }
        else
        {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == ""
        {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }
        else
        {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
}

