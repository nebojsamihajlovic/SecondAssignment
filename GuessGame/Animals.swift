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
    }
    
    var animal: Animal = .DOG
    
    var animalImage = UIImage(named: "DOG")
    
    static func random() -> Animals {
        let random = Int.random(upper_bound: 5)
        
        var imageName: String
        switch random {
        case 0:
            imageName = "DOG"
        case 1:
            imageName = "HORSE"
        case 2:
            imageName = "MOUSE"
        case 3:
            imageName = "TURTLE"
        case 4:
            imageName = "ZEBRA"
        default:
            imageName = "DOG"
        }
        
        return Animals(animal: Animal(rawValue: imageName)!, animalImage: UIImage(named: imageName ))
    }
}
