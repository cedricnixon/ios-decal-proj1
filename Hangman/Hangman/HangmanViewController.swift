//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    var gamePlay : Game?
    @IBOutlet weak var progress: UILabel!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var prevGuesses: UILabel!
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reStart(_ sender: Any) {
        startOver()
    }
    
    func startOver() {
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase = hangmanPhrases.getRandomPhrase()
        gamePlay = Game(str: phrase)
        self.progress.text = gamePlay?.progress
        self.prevGuesses.text = ""
        setImage()
        print(phrase)
    }
    
    @IBAction func makeGuess(_ sender: UIButton) {
        if (gamePlay?.isLegal(str: textInput.text!))! {
            gamePlay?.makeGuess(str: textInput.text!)
            self.progress.text = gamePlay?.progress
            self.prevGuesses.text = "Incorrect Guesses:\n" + (gamePlay?.prevText)!
            setImage()
            if (gamePlay?.isWin())! {
                winAlert()
            }
            if (gamePlay?.isLoss())! {
                lossAlert()
            }
        }
    }
    
    func setImage() {
        let state = (gamePlay?.incorrectGuesses)! + 1
        image.image = UIImage(named: "hangman\(state)")
    }
    
    func winAlert() {
        let alert = UIAlertController(title: "You won.", message:
            "Nice job.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Keep Playing", style: UIAlertActionStyle.default,handler: startOver))
        self.present(alert, animated: true, completion: nil)
    }
    
    func startOver(alert: UIAlertAction!) {
        startOver()
    }
    
    func lossAlert() {
        let alert = UIAlertController(title: "You lost.", message:
            ":(", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Keep Playing", style: UIAlertActionStyle.default,handler: startOver))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
