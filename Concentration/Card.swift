//
//  Card.swift
//  Concentration
//
//  Created by WillJia on 2018-04-22.
//  Copyright © 2018 WillJia. All rights reserved.
//

// User Story #67 - Task 6

import Foundation

//MARK: This is model file sub class, which is UI independent

/* struct no inheritance
 struct are value types
 class are reference types
 int, dictionays , arrays are structs
 the big difference are copy or not
 
 
*/
struct Card : Hashable
{
    var hashValue: Int{return identifier}

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
//  private var identifier: Int (should be )

    
    //MARK: no emoji : model's class are UI independent never UI
    
    // banded with type
    private static var identifierFactory = 0
    /*
    // static func is a message from type - Card
    // like type banded
    */
    private static func getUniqueIdentifier() -> Int {
        // don't need Card.identifieerFactory
        // because it's in type class
        identifierFactory += 1
        return identifierFactory
    }
    
    
    
    init()
    {
        // self. my.****
        self.identifier = Card.getUniqueIdentifier()
    }
}










































