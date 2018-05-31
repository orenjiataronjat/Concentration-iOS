//
//  ViewController.swift
//  Concentration
//
//  Created by David Lattimer on 5/14/18.
//  Copyright © 2018 David Lattimer. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var startTheme = Theme(name: "Halloween", emojis: ["👻","🎃","😱","😈","🧛🏻‍♂️","🦇","🍎","👹"], primaryColor: UIColor.orange, secondaryColor: UIColor.black)

    var christmasTheme = Theme(name: "Christmas", emojis: ["🎄","❄️","⛄️","🤶🏻","🎅🏻","🦌","🍪","🥛"], primaryColor: UIColor.green, secondaryColor: UIColor.white)
    
    var emojiTheme = Theme(name: "Emojis", emojis: ["😡","🤪","😎","😘","😱","🤢","🤯","😃"], primaryColor: UIColor.yellow, secondaryColor: UIColor.white)
    
    var sportsTheme = Theme(name: "Sports", emojis: ["🏈","⚾️","🏀","⚽️","🏐","🎾","🥊","🏊🏻‍♂️"], primaryColor: UIColor.blue, secondaryColor: UIColor.black)
    
    var handsTheme = Theme(name: "Hands", emojis: ["👍🏻","👎🏻","👊🏻","🤞🏻","✌🏻","🖖🏻","👋🏻","👌🏻"], primaryColor: UIColor.gray, secondaryColor: UIColor.cyan)
    
    var catFacesTheme = Theme(name: "Cats", emojis: ["😺","😾","😹","😻","😼","😽","🙀","😿"], primaryColor: UIColor.magenta, secondaryColor: UIColor.darkGray)
    
    lazy var themes = [startTheme, christmasTheme, emojiTheme, sportsTheme, handsTheme, catFacesTheme]
    lazy var selectedTheme = startTheme
    lazy var emojiChoices = selectedTheme.emojiChoices

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        selectedTheme = themes[Int(arc4random_uniform(UInt32(themes.count)))]
        self.view.backgroundColor = selectedTheme.secondaryColor
        flipCountLabel.textColor = selectedTheme.primaryColor
        scoreCountLabel.textColor = selectedTheme.primaryColor
        sender.backgroundColor = selectedTheme.primaryColor
        emojiChoices = selectedTheme.emojiChoices
        flipCountLabel.text = "Flips: 0"
        scoreCountLabel.text = "Score: 0"
        
        for index in cardButtons.indices {
            cardButtons[index].backgroundColor = selectedTheme.primaryColor
            cardButtons[index].setTitle("", for: UIControlState.normal)
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("Choosen card was not in set cardButtons")
        }
    }
    
    func updateViewFromModel(){
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreCountLabel.text = "Score: \(game.scoreCount)"
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : selectedTheme.primaryColor
            }
        }
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = selectedTheme.primaryColor
        }else{
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
