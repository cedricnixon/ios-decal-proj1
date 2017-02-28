//
//  Game.swift
//  Hangman
//
//  Created by Cedric Nixon on 2/27/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation

class Game {
    let word : String
    var progress : String
    var prevGuesses : [Character]
    var prevText : String
    var incorrectGuesses : Int
    init(str : String) {
        self.word = str
        self.prevGuesses = [Character]()
        self.incorrectGuesses = 0
        self.progress = ""
        self.prevText = ""
        rebuildLabel()
    }
    
    func isLegal(str : String) -> Bool {
        let count = str.characters.count
        if count <= 0 || count > 1 {
            return false
        }
        for char in prevGuesses {
            if String(char) == str.uppercased() {
                return  false
            }
        }
        return true
    }
    
    func makeGuess(str: String) {
        let str2 = str.uppercased()
        let char = str2[str2.startIndex]
        prevGuesses.append(char)
        if !self.word.contains("\(char)") {
            self.incorrectGuesses += 1
        }
        rebuildLabel()
    }
    
    func isLoss()-> Bool {
        return incorrectGuesses >= 6
    }
    
    func isWin()-> Bool {
        for char in progress.characters {
            if char == "_" {
                return false
            }
        }
        return true
    }
    
    func rebuildLabel() {
        self.progress = ""
        self.prevText = ""
        for char in word.characters {
            if char == " " {
                self.progress += "  "
            } else if prevGuesses.contains(char) {
                self.progress.append(char)
                self.progress += " "
            } else {
                self.progress += "_ "
            }
        }
        for char in prevGuesses {
            if !self.word.contains(String(char)) {
                self.prevText.append(char)
                self.prevText.append(" ")
            }
        }
    }
}
