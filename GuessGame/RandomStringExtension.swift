//
//  RandomStringExtension.swift
//  GuessGame
//
//  Created by Nebojsa Mihajlovic on 2/16/17.
//  Copyright © 2017 course. All rights reserved.
//

import Foundation

extension String {
    
    static func randomizeAnimalString(randomizeString forAnimal: String) -> String {
        
        let letters: NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let len = UInt32(letters.length)
        
        var randomized = forAnimal
        
        for _ in 0 ..< 12 - forAnimal.characters.count
        {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomized += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomized
    }

}
