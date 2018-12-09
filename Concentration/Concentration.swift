//
//  Concentration.swift
//  Concentration
//
//  Created by WillJia on 2018-04-22.
//  Copyright © 2018 Zesheng Jia A00416452. All rights reserved.
//

//MARK: This is model file, which is UI independent
import Foundation

//when create a new public class, always think about public API included
//at the beginning

struct Concentration { // value type. constant copy everywhere
    // effience
    // class is reference type. pionter everywhere
    
    // empty arrays , exists but empty
    //var cards = Array<Card>()
    // has to be public
    private(set) var cards = [Card]()
    
    // set : 1 // no set 0,2
    // if 2 cards faced up it is not only one face up
    // var indexOfOneAndOnlyFaceUpCard: Int?
    
    // change to computed propeties
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
//            let faceUpCardIndices = cards.indices.filter{ cards[$0].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil

            // use closure and protocol 
            return cards.indices.filter{ cards[$0].isFaceUp}.oneAndyOnly
            
//            var foundIndex : Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp{
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{ // contain set then this var is mutatable
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    // User Story #67 - Task 9
    
    var numberOfCards = 0
    
    mutating func chooseCard(at index:Int){ // index based
        
        // use accestion to protect API
        assert(cards.indices.contains(index) , "Concentration.chooseCard(at: \(index)) : chosen index not in the cards")
        
        
        
        /* 64518 drop use another way
        //        if cards[index].isFaceUp {
        //            cards[index].isFaceUp = false
        //        }else{
        //            cards[index].isFaceUp = true
        //        }
        cards[index].isFaceUp = !cards[index].isFaceUp
        */
        
        // use optional to choose card
        // ignore card has been matched
        // no cards face up or two cards face up
        // 1 cards face up and filp another card and check if it match
        if !cards[index].isMatched{
        
            if let matchIndex = indexOfOneAndOnlyFaceUpCard , matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                //
                cards[index].isFaceUp = true
                
            }else{
                // either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // User Story #67 - Task 8
    
    init(numberOfPairsOfCard:Int) {
        
        assert(numberOfPairsOfCard > 0, "init(at: \(numberOfPairsOfCard)) :  you must have at least on pair of card")

        
        /* 0
         sequence can be used by iterator
         countable range
         0..< start from zero to number but not include number
         0... include the number
         */
        /* 6
         for identifier in 1...numberOfPairsOfCard{ // countable range
         instead of using this , we can use _ (under bar)
         to tell for func we don't care about the item in countable range
         */
        
        numberOfCards = numberOfPairsOfCard * 2
        
        for _ in 1...numberOfPairsOfCard{ // countable range
            
            // 5
            // instead of doing this, we should let Cards itself pick unique
            // indentifier
            // let card = Card(identifier: identifier)
            
            let card = Card()
            /*  1
             let matchingCard = Card(identifier: identifier)
             //instead of doing this, we can
             let matchingCard = card
             cards.append(matchingCard)
             */
            //  2
            // instead of doing that, we can
            // because into an array, we just use copies, not reference item
            /*
             cards.append(card)
             cards.append(card)
             */
            
            // instead of doing that, we can
            
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        shuffleCards()
    }
    
    mutating func shuffleCards(){
        var arrayOfCardsIdentifier  = Array(repeating: 0, count: numberOfCards)
        var ident = 0
        for num in 0..<arrayOfCardsIdentifier.count {
            arrayOfCardsIdentifier[num] = ident
            if (num+1) % 2 == 0{
                ident += 1
            }
        }
        
        for index in  0..<(numberOfCards) {
            if arrayOfCardsIdentifier.count > 0{
                let randomValue = Int(arc4random_uniform(UInt32(arrayOfCardsIdentifier.count)))
                cards[index].identifier = arrayOfCardsIdentifier.remove(at: randomValue)
            }
        }
    }
    
    mutating func cleanCards(){
        var ident = 0
        for i in 0..<numberOfCards{
            cards[i].isFaceUp = false
            cards[i].isMatched = false
            cards[i].identifier = ident
            if (i+1) % 2 == 0{
                ident += 1
            }
        }
    }
    
   mutating func restartGame () {
        cleanCards()
        shuffleCards()
    }
    

}




extension Collection{
    var oneAndyOnly: Element? {
        return count == 1 ? first : nil
    }
}


































