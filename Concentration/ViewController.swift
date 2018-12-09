//
//  ViewController.swift
//  Concentration
//  Tag upload test
//  Created by WillJia on 2018-04-19.
//  Copyright © 2018 Zesheng Jia A00416452. All rights reserved.
//


//MARK: This is a MVC controller :

//Cocoa touch layer
import UIKit

// name of class
class ViewController: UIViewController {
    
    
    /*
     // start wrtie green arrow
     // class gets free inits (empty one) as long as all of their vars are initialized
     // lazy : doesn't initialize game until someone start to use game
     // lazy can not have a didSet
     */
    // the number of cards is connected to UI
    private lazy var game = Concentration(numberOfPairsOfCard:numberOfPairsOfCard )
    
    // read only properties, not settable anyway
    var numberOfPairsOfCard : Int {
        return (cardButtons.count + 1)/2
    }
 
    
    /* every valuable must be initialize in swift
     swift has strong type reference and it will guess type for you
     var flipCount : Int = 0 dismiss
     */
    
    lazy var cardsLeft = cardButtons.count
    
    
    private(set) var flipCount = 0 {
        
        // it will run every time when the flipCount changes
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // MARK: ! is super important symbol in swift
    // MARK: always put IBOutlet private
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    // user command key to rename valuable's name with button in UI
    
    @IBOutlet private var cardButtons: [UIButton]!
    // an array of UIButtons same as Array<UIButton>
    
    
    /*    First version of
     *   @IBAction func touchCard(_ sender: UIButton)
     *     _ :means no elements needed and don't care
     **    _ :external name don't user too much
     *    sender : internal name of button
     */
    /* Second version
     * Control drag the second button to the below code */
    
    @IBOutlet private weak var restartGameButton: UIButton!
    
    @IBAction private func restartGame(_ sender: UIButton) {
        if cardsLeft < 3 {
            cardsLeft = cardButtons.count
            flipCount = 0
            game.restartGame()
            updateViewFromModel()
        }
    }
    
    // User Story #67 - Task 5
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        // every time copy and paste code it's wrong
        
        flipCount += 1
        
        /*
         create an array to save emojis
         Variable 'cardNumber' was never mutated; consider changing to 'let' constant
         let cardNumber = cardButtons.index(of: sender)!
         ! could make option type return value in it, and if it's nil
         then crash.
         
         Button's index is a optional type , it only have set and unset. set with value
         */
        
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            // update view from model
            updateViewFromModel()
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }else{
            print("chosen card was not in cardButtons")
        }
        
        
        
        /*first version
         flipCard(withEmoji: "👻", on: sender)
         */
    }
    
    /*    First version of @IBAction func touchSecondCard(_ sender: UIButton)
     each time copy a button , remember to remove the connectiong with its older one
     @IBAction func touchSecondCard(_ sender: UIButton) {
     flipCount += 1
     flipCard(withEmoji: "🎃", on: sender)
     }
     */
    
    // User Story #67 - Task 10
    
    private func updateViewFromModel(){
        
        //      for index in 0..<cardButtons{
        var checkFlipCardsNum = 0
        
        for index in cardButtons.indices{
            
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for : card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                // option with left click going into documentation
                // and read overview
                if(!card.isMatched) {
                    button.setTitle("🎴", for: UIControlState.normal)
                    
                }else{
                    button.setTitle("", for: UIControlState.normal)

                }
                // if is matched, it will be full transparnce
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                
            }
            if card.isMatched {
                checkFlipCardsNum += 1
            }
        }

        
        if (cardsLeft - checkFlipCardsNum) > 0 {
            restartGameButton.setTitle("", for: UIControlState.normal)
            restartGameButton.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0)
        }else{
            cardsLeft = 2
            restartGameButton.setTitle("New Game", for: UIControlState.normal)
            restartGameButton.setTitleColor(#colorLiteral(red: 1, green: 0.286344804, blue: 0.1459060344, alpha: 1), for: UIControlState.normal)
            restartGameButton.backgroundColor = #colorLiteral(red: 1, green: 0.8985673876, blue: 0.2972180715, alpha: 1)
        }
        
    }
    
    // User Story #67 - Task 7
    
//    private var emojiChoices = ["🦇", "😱", "🙀","😈","🎃","👻","🍭","🍬","🍎"]
    private var emojiChoices = "🦇🐌🐼🐣🐲🌜🐰🍄🐿"

    
    // use dictionaries
    // and empty dictionaries
    //var emoji = Dictionary<Int, String>()
    private var emoji = [Card : String]()
    
    
    private func emoji (for card : Card) -> String {
        
        // choseEmoji is optional
        // because if we look into a dictionary
        // the value or item could not be in there then not set
        /*
         if emoji[card.identifier] != nil{
         return emoji[card.identifier]!
         } else{
         return "?"
         }
         exactly same as following ones
         */
        
        if emoji[card] == nil , emojiChoices.count > 0 {
            
                // randomIndex also a UInt if not use type conversion
                //let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                // this will work, but it will have more than 2 same emojis
                // so we change this
                //emoji[card.identifier] = emojiChoices[randomIndex]
            
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy:emojiChoices.count.arc4random)
            // string is a character of collection not a directly string
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    /* 60513 don't need anymore
     // function's name should be English
     func flipCard( withEmoji emoji : String , on button: UIButton){
     
     // optional types
     if button.currentTitle == emoji {
     
     // option with left click going into documentation
     // and read overview
     button.setTitle("", for: UIControlState.normal)
     button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
     }else{
     button.setTitle(emoji, for: UIControlState.normal)
     button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
     }
     }
     
     
     
     */
}

    // extension must after the class
    extension Int {
        var arc4random : Int {
            if self > 0 {
                return Int(arc4random_uniform(UInt32(self)))
            } else if self < 0{
                return -Int(arc4random_uniform(UInt32(abs(self))))
            } else{
                return 0
            }
        }
    }

























