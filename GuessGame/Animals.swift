//
//  Animals.swift
//  GuessGame
//
//  Created by Nebojsa Mihajlovic on 2/16/17.
//  Copyright © 2017 course. All rights reserved.
//

import Foundation
import UIKit

struct Animals
{
    enum Animal: String {
        case DOG
        case HORSE
        case MOUSE
        case TURTLE
        case ZEBRA
        
        var name: String {
            return self.rawValue
        }
    }
    
    var animal: Animal = .DOG
    
    var animalImage = UIImage(named: "DOG")
    
    static func random() -> Animals {
        let random = Int.random(upper_bound: 5)
        
        var imageName: String
        switch random {
        case 0:
            imageName = Animal.DOG.name
        case 1:
            imageName = Animal.HORSE.name
        case 2:
            imageName = Animal.MOUSE.name
        case 3:
            imageName = Animal.TURTLE.name
        case 4:
            imageName = Animal.ZEBRA.name
        default:
            imageName = Animal.DOG.name
        }
        
        return Animals(animal: Animal(rawValue: imageName)!, animalImage: UIImage(named: imageName ))
    }
}
