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
    
    @IBOutlet weak var TimerLabel: UILabel!
    var model = CardModel()
    var cardsArray = [Card]()
    
    var timer : Timer?
    var milliseconds : Int = 10 * 1000
    var firstFlippedCardIndex : IndexPath?
    var soundPlayer = SoundManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardsArray = model.getCard()
        
        //Set the ViewController as the dataSource & the delegete of the collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //initilize the timer
        timer = Timer.scheduledTimer(timeInterval: 1/1000, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        //Add it to a seperated background loop so it doesn't interfer with the main loop of the collection view that is already running
        RunLoop.main.add(timer!, forMode: .common)
        

        
    }
    override func viewDidAppear(_ animated: Bool) {
        //Play shuffle Sound
        soundPlayer.playSound(effect: .shuffle)
    }
    
    
    //MARK: - Timer Method
    //exposing the swift method to the objective c tag
    @objc func timerFired(){
        //Decrement the counter
        milliseconds -= 1
        
        // update the label
        let seconds : Double = Double( milliseconds)/1000.0
        TimerLabel.text = String(format: "Time Remaining %.2f", seconds)
        
        // stop the timer if it reaches zero
        if milliseconds == 0 {
            //stops the timer
            TimerLabel.textColor = UIColor.red
            timer?.invalidate()
        }
        
        // check if the user has cleared all the pairs
        checkForGameEnd()
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
        
        // Return it
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)  {
        
        // Configuire the state of the cell based on the properties of the card
        
        //casting the cell to be a card collection view cell
        let cardCell = cell as? CardCollectionViewCell
        // TODO: configre it
        cardCell?.configureCell(card: cardsArray[indexPath.row])
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        //Get a refrence to the cell that was tapped
        let cell =  collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        //check the status of the card is flipped or not and do the oppesite
        if(cell?.card?.isFlipped == false && cell?.card?.isMatched == false ){
            
            //flip the card up
            cell?.flipUp()
            
            //Play flip Sound
            soundPlayer.playSound(effect: .flip)

            
            //check if the this is the first card that was flipped or the second card
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            }
            else {
                // second card is flipped
                
                // Run the comparition logic
                checkForMatch(indexPath)
                
                
            }
            
            
        }
    }
    
    //MARK: Game Logic Methods
    
    func checkForMatch(_ secondFlippedCardIndex : IndexPath ) {
        
        //Get the two card objects for the two indicies and see if they match
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        //get the two collection view cells that have been flipped over
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        
        //compare the two cards
        if (cardOne.imageName == cardTwo.imageName){
            //it's a match
            
            //Play Match Sound
            soundPlayer.playSound(effect: .match)

            
            cardOne.isMatched = true
            
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            //Was that the last pair ?
            checkForGameEnd()
            
        }
        else {
            //it is not a match
            
            //Play not a match  Sound
            soundPlayer.playSound(effect: .noMatch)

            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            // flip them over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        //reset the first flipped card index
        firstFlippedCardIndex = nil
    }
    
    
    func checkForGameEnd (){
        
        //check if there any card that is un matched
        var hasWon = true
        
        //assume the user won then lopp through all the card array to see of they all matched
        for card in cardsArray {
            if card.isMatched == false {
                //we found a card that is not matched
                hasWon = false
                break
            }
        }
        if hasWon {
            //User has won , show an alert
            showAlert(title: "Congratiolations!", message: "You won the game ! ")
        }
        else {
            
            //User hasn't win yet , check if there any time left
            if milliseconds <= 0 {
                showAlert(title: "Time's Up ", message: "Sorry ,better luck next time !")
            }
        }
    }
    func showAlert (title : String , message : String ){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //Add a button for the user to dismiss it
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        //present the message
        present(alert, animated: true)
    }
}

