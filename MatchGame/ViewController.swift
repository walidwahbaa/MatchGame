//
//  ViewController.swift
//  MatchGame
//
//  Created by walid wahba on 30.10.2023.
//

import UIKit

//We want to set the view controller as the object that is gonna be suppling the data to the collecetion view & responsable for handling the user  interaction events from the collection view
class ViewController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardsArray = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardsArray = model.getCard()
        
        //Set the ViewController as the dataSource & the delegete of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    //MARK: Collection View Delegete Methods
    //the collection view is asking the view controller how many items i should display
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return number of cards
        cardsArray.count
    }
    //the index path tells you exactly which cell in the collection view that we are talking about
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //get a cell
        // try to look for a cell that it can reuse or creating a new one and return it
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        // deque doesnot know the data type of the cell he is returning so we need to cast that object and say that it is a card collection view cell
        
        // TODO: configre it
        cell.configureCell(card: cardsArray[indexPath.row])
        
        // Return it
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        //Get a refrence to the cell that was tapped
       let cell =  collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        //check the status of the card is flipped or not and do the oppesite
        (cell?.card?.isFlipped == true) ? cell?.flipDown() : cell?.flipUp()
   
    }
    
}

