//
//  GameViewController.swift
//  GuessGame
//
//  Created by Nebojsa Mihajlovic on 2/16/17.
//  Copyright © 2017 course. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    // always has a value (at least default)
    var randomAnimal: Animals!
    var game = Game()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var animalView: UIImageView!
    @IBOutlet weak var buttonNewGame: UIButton!
    
    @IBOutlet weak var viewProposedLetters: UIView!
    @IBOutlet weak var viewPlayerLetters: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        disableAllProposedLettersButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onProposedLetterButtonsClicked(_ sender: UIButton) {
        
        print("Clicked on proposed letter button")
        
        let alertsInseadOfViewsOnEndGame = true
        
        if let text = sender.titleLabel?.text {
            print("Letter chosen: \(text)")
            
            let result = game.tryLetter(inAnimal: text)
            if result == -1
            {
                print("Letter not found")
                
                // check if game is completed - fail
                if game.gameOver == true
                {
                    print("Game Over - FAILED")
                    showEndGameView(success: false, alerts: alertsInseadOfViewsOnEndGame)
                }
            }
            else
            {
                print("Letter found!")
                
                let letterButton = viewPlayerLetters.subviews[result]
                
                (letterButton as! UIButton).backgroundColor = .yellow
                (letterButton as! UIButton).setTitle(text, for: .normal)
                

                // check if game is completed - success
                if game.gameOver == true
                {
                    print("Game Over - SUCESS")
                    showEndGameView(success: true, alerts: alertsInseadOfViewsOnEndGame)
                }
            }
        }
        
        sender.isEnabled = false
        sender.backgroundColor = UIColor.gray
    }
    
    func showEndGameView(success: Bool, alerts: Bool)
    {
        // first disable all buttons
        disableAllProposedLettersButtons()
        
        
        if alerts == false
        {
            createEndView(success: success)
        }
        else
        {
            createLevelClearAlert(success: success)
        }
    }
    
    func createLevelClearAlert(success: Bool)
    {
        if success == true
        {
            let alert = UIAlertController(title: "Level Clear", message: "Do you want to replay level or to start new game?", preferredStyle: .alert)
            
            for i in ["Replay level", "Start new game"]
            {
                alert.addAction(UIAlertAction(title: i, style: .default, handler: replayOrStartNewLevel))
            }
            
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Game Over", message: "Do you want start level from beggining?", preferredStyle: .alert)
            
            for i in ["Yes", "No"]
            {
                alert.addAction(UIAlertAction(title: i, style: .default, handler: startLevelFromBeginnig))
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func replayOrStartNewLevel(action: UIAlertAction) {
        
        let userAction = action.title ?? "Start new game"
        
        if userAction == "Replay level"
        {
            print("Replay level ...")
            restartLevel()
        }
        else
        {
            print("Starting new game ...")
            startNewGame()
        }
    }
    
    func startLevelFromBeginnig(action: UIAlertAction) {
        
        let userAction = action.title ?? "No"
        
        if userAction == "Yes"
        {
            print("Replay level ...")
            restartLevel()
        }
        else
        {
            print("Starting new game ...")
            startNewGame()
        }
    }
    
    func restartLevel()
    {
        clearPlayerLetterViewButtons()
        game.initialize(animal: randomAnimal.animal.rawValue)
        
        // begin new game
        for btn in viewProposedLetters.subviews
        {
            (btn as! UIButton).isEnabled = true
            (btn as! UIButton).backgroundColor = UIColor.blue
        }
    }
    
    func createEndView(success: Bool)
    {
        let viewEndGame = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        
        viewEndGame.textAlignment = .center
        viewEndGame.font = UIFont.boldSystemFont(ofSize: 36.0)
        viewEndGame.translatesAutoresizingMaskIntoConstraints = false
        viewEndGame.tag = 999 // set tag value so we can remove it from superview
        
        if success == true
        {
            viewEndGame.backgroundColor = .green
            viewEndGame.text = "CORRECT!"
        }
        else
        {
            viewEndGame.backgroundColor = .red
            viewEndGame.text = "GAME OVER!"
        }
        
        self.animalView.addSubview(viewEndGame)
        
        let centerX = NSLayoutConstraint(
            item: viewEndGame,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: animalView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)
        
        let centerY = NSLayoutConstraint(
            item: viewEndGame,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: animalView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0)
        
        let leading = NSLayoutConstraint(
            item: viewEndGame,
            attribute: .leading,
            relatedBy: .equal,
            toItem: animalView,
            attribute: .leading,
            multiplier: 1,
            constant: 16)
        
        let trailing = NSLayoutConstraint(
            item: viewEndGame,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: animalView,
            attribute: .trailing,
            multiplier: 1,
            constant: -16)
        
        animalView.addConstraints([centerX, centerY, leading, trailing])
        
        buttonNewGame.setTitle("NEW GAME", for: .normal)
    }
    
    func getRandomAnimalAndSetupImageView()
    {
        randomAnimal = Animals.random()
        
        imageView.image = randomAnimal.animalImage
        
        let randomizedAnimal = String.randomizeAnimalString(randomizeString: randomAnimal.animal.rawValue)
        print("Randomized animal string: \(randomizedAnimal)")
        
        // convert to array
        let characters = randomizedAnimal.characters.shuffled()
        print("Shuffled randomized animal string: \(characters)")
        
        // set randomized string characters as button labels
        var counter = 0
        for btn in viewProposedLetters.subviews
        {
            (btn as! UIButton).setTitle(String(characters[counter]), for: .normal)
            counter += 1
        }
        
        // initialize game
        game.initialize(animal: randomAnimal.animal.rawValue)
    }
    
    func clearPlayerLetterViewButtons()
    {
        let length = randomAnimal.animal.rawValue.characters.count
        var counter = 0
        
        
        for btn in viewPlayerLetters.subviews
        {
            (btn as! UIButton).isEnabled = false
            (btn as! UIButton).setTitle(" ", for: .normal)
            
            counter += 1
            if counter > length
            {
                (btn as! UIButton).backgroundColor = .lightGray
            }
            else
            {
                (btn as! UIButton).backgroundColor = .black
            }
        }
    }
    
    func restartLevel(action: UIAlertAction) {
        
        let userAction = action.title ?? "No"
        
        if userAction == "Yes"
        {
            print("Restarting level ...")
            restartLevel()
        }
    }
    
    @IBAction func btnNewGameClicked(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "RESTART LEVEL"
        {
            let alert = UIAlertController(title: "Restart Level", message: "Do you really want to restart level?", preferredStyle: .alert)

            for i in ["Yes", "No"]
            {
                alert.addAction(UIAlertAction(title: i, style: .default, handler: restartLevel))
            }
        
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        startNewGame()
    }
    
    func startNewGame()
    {
        // begin new game
        for btn in viewProposedLetters.subviews
        {
            (btn as! UIButton).isEnabled = true
            (btn as! UIButton).setTitle(" ", for: .normal)
            (btn as! UIButton).backgroundColor = UIColor.blue
        }
        
        getRandomAnimalAndSetupImageView()
        clearPlayerLetterViewButtons()
        
        removeEndGameMessageFromSuperView()
        
        buttonNewGame.setTitle("RESTART LEVEL", for: .normal)
    }
    
    func removeEndGameMessageFromSuperView()
    {
        let subViews = self.animalView.subviews
        for subview in subViews
        {
            if subview.tag == 999
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    func disableAllProposedLettersButtons()
    {
        for btn in viewProposedLetters.subviews
        {
            (btn as! UIButton).isEnabled = false
        }
    }
}
