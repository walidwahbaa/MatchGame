//
//  ViewController.swift
//  MatchGame
//
//  Created by walid wahba on 30.10.2023.
//

import UIKit

class ViewController: UIViewController {
    var model = CardModel()
    var cardsArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardsArray = model.getCard()
    }


}

