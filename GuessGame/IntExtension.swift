//
//  IntExtension.swift
//  GuessGame
//
//  Created by Nebojsa Mihajlovic on 2/16/17.
//  Copyright © 2017 course. All rights reserved.
//

import Foundation

extension Int {
    static func random(upper_bound: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upper_bound)))
    }
}
