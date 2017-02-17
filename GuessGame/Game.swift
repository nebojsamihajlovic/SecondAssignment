//
//  Game.swift
//  GuessGame
//
//  Created by Nebojsa Mihajlovic on 2/17/17.
//  Copyright © 2017 course. All rights reserved.
//

import Foundation

class Game {
    
    var failsCounter = 0
    var hitsCounter = 0
    var animalToGuess: String
    var animalToGuessLength = 0
    
    var gameOver = false
    
    init()
    {
        animalToGuess = ""
    }

    func initialize(animal: String)
    {
        failsCounter = 0
        hitsCounter = 0
        animalToGuess = animal
        animalToGuessLength = animalToGuess.characters.count
        
        gameOver = false
    }
    
    // methods
    public func tryLetter(inAnimal: String) -> Int {
        var pos = -1
        
        if let index = animalToGuess.characters.index(of: Character(inAnimal))
        {
            pos = animalToGuess.characters.distance(from: animalToGuess.startIndex, to: index)
            print("Found \(inAnimal) at position \(pos)")
            
            let range = animalToGuess.range(of: inAnimal)
            animalToGuess = animalToGuess.replacingOccurrences(of: inAnimal, with: "_", options: .literal, range: range)
            
            print("String to guess after removal of proposed letter: \(animalToGuess)")
            
            hitsCounter += 1
            if hitsCounter == animalToGuessLength
            {
                gameOver = true
            }

            return pos;
        }
        else
        {
            print("Letter \(inAnimal) not found!")
            failsCounter += 1
            print("Wrong tries counter = \(failsCounter)")
            
            if failsCounter == 3
            {
                gameOver = true
            }
            
            return -1
        }
    }
}
