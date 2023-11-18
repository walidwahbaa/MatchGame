//
//  CardModel.swift
//  MatchGame
//
//  Created by walid wahba on 31.10.2023.
//

import Foundation
class CardModel {
    func getCard() -> [Card] {
        
        //create an empty array
        var generatedCards = [Card]()
        
        // randomly generate 8 pairs of cards
        for _ in 1...8 {
            
            //generate a random number
            let randomNumber =  Int.random(in: 1...13)
            
            //generate a two card objects
            let card1 = Card()
            let card2 = Card()
            
            // set their image name
            card1.imageName = "card\(randomNumber)"
            card2.imageName = "card\(randomNumber)"
            //add them to the array
            generatedCards += [card1,card2]
            print(randomNumber)
            
            
        }
        
        // randomise the cards within the array
        generatedCards.shuffle()
        
        //return the array
        return generatedCards
        
        
        
    }
}
