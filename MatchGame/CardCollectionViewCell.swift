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
        
        //reset the state of the cell by checking the flip status of the card and then showing the front or the back accordiningly
        
        card.isFlipped ? flipUp(speed: 0) : flipDown(speed: 0)
    }
    
    func flipUp(speed : TimeInterval = 0.3) {
        
        //Flip up animation
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews , .transitionFlipFromLeft] , completion: nil)
        
        //set the status of the card to be flipped
        card?.isFlipped = true
    }
    
    func flipDown(speed : TimeInterval = 0.3) {
        
        //Flip down animation
        UIView.transition(from: frontImageView, to: backImageView, duration: speed , options: [.showHideTransitionViews , .transitionFlipFromLeft] , completion: nil)
        
        //reset the status of the flipping card
        card?.isFlipped = false
    }

}
