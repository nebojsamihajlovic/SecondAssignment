//
//  GameViewController.swift
//  GuessGame
//
//  Created by Nebojsa Mihajlovic on 2/16/17.
//  Copyright © 2017 course. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var btnSolutionLetter1: UIButton!
    @IBOutlet weak var btnSolutionLetter2: UIButton!
    @IBOutlet weak var btnSolutionLetter3: UIButton!
    @IBOutlet weak var btnSolutionLetter4: UIButton!
    @IBOutlet weak var btnSolutionLetter5: UIButton!
    @IBOutlet weak var btnSolutionLetter6: UIButton!
    
    @IBOutlet weak var viewProposedLetters: UIView!
    
    @IBOutlet weak var btnProposedLetter1: UIButton!
    @IBOutlet weak var btnProposedLetter2: UIButton!
    @IBOutlet weak var btnProposedLetter3: UIButton!
    @IBOutlet weak var btnProposedLetter4: UIButton!
    @IBOutlet weak var btnProposedLetter5: UIButton!
    @IBOutlet weak var btnProposedLetter6: UIButton!
    @IBOutlet weak var btnProposedLetter7: UIButton!
    @IBOutlet weak var btnProposedLetter8: UIButton!
    @IBOutlet weak var btnProposedLetter9: UIButton!
    @IBOutlet weak var btnProposedLetter10: UIButton!
    @IBOutlet weak var btnProposedLetter11: UIButton!
    @IBOutlet weak var btnProposedLetter12: UIButton!
    
    // always has a value (at least default)
    var randomAnimal : Animals!
    
    func getRandomAnimalAndSetupImageView()
    {
        randomAnimal = Animals.random()
        
        imageView.image = randomAnimal.animalImage
        let animalName = randomAnimal.animal.rawValue
        
        // print("animalName.characters:")
        // print(animalName.characters)
        
        // print("animalName.characters.count:")
        // print(animalName.characters.count)
        
        let randomizedAnimal = String.randomizeAnimalString(randomizeString: animalName)
        print(randomizedAnimal)
        
        // convert to array
        let characters = randomizedAnimal.characters.shuffled()
        print(characters)
        
        // set randomized string characters as button labels
        var counter = 0
        for btn in viewProposedLetters.subviews
        {
            (btn as! UIButton).setTitle(String(characters[counter]), for: .normal)
            
            counter += 1
        }
    }
    
    @IBAction func btnNewGameClicked(_ sender: UIButton) {
        // begin new game
        getRandomAnimalAndSetupImageView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
