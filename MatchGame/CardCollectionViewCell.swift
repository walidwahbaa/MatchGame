//
//  CardCollectionViewCell.swift
//  MatchGame
//
//  Created by walid wahba on 17.11.2023.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card : Card?
    func configureCell (card:Card){
        
        //Keep track of the card
        self.card = card
        
        //Set the front image view to the image that represente the card
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        }
        else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        //reset the state of the cell by checking the flip status of the card and then showing the front or the back accordiningly
        
        card.isFlipped ? flipUp(speed: 0) : flipDown(speed: 0 , delay: 0)
    }
    
    func flipUp(speed : TimeInterval = 0.3) {
        
        //Flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews , .transitionFlipFromLeft] , completion: nil)
        
        //set the status of the card to be flipped
        card?.isFlipped = true
    }
    
    func flipDown(speed : TimeInterval = 0.3 , delay : TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: {
            
            //Flip down animation
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed , options: [.showHideTransitionViews , .transitionFlipFromLeft], completion: nil)
            
        })
        
        //reset the status of the flipping card
        card?.isFlipped = false
    }
    func remove (){
        
        //Make the image views invisible
        backImageView.alpha = 0  
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            // it takes whatever the value outside the animation block to the value inside here
            self.frontImageView.alpha = 0
            
        },completion: nil)
    }
    
}
