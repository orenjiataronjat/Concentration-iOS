//
//  Concentration.swift
//  Concentration
//
//  Created by David Lattimer on 5/14/18.
//  Copyright © 2018 David Lattimer. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var mismatch = [Int]()
    var flipCount = 0
    var scoreCount = 0
    var indexOfOneAndOnlyOne: Int?
    
    func chooseCard(at index: Int){
        flipCount += 1
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyOne, matchIndex != index{
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2
                }
                else{
                    if mismatch.contains(cards[index].identifier){
                        scoreCount += -1
                    }else{
                        mismatch.append(cards[index].identifier)
                    }
                    if mismatch.contains(cards[matchIndex].identifier){
                        scoreCount += -1
                    }else{
                        mismatch.append(cards[index].identifier)
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOne = nil
            } else{
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOne = index
            }
        }
    }
    
    func shuffle() -> [Card]{
        var outputCards: [Card] = []
        for _ in 0..<cards.count{
            let card = cards.remove(at: Int(arc4random_uniform(UInt32(cards.count))))
            outputCards.append(card)
        }
        return outputCards
    }
    
    init(numberOfPairsOfCards: Int){
        flipCount = 0
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        cards = shuffle()
    }
}
