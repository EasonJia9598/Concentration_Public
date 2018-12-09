////
////  L4.swift
////  Concentration
////
////  Created by WillJia on 2018-10-02.
////  Copyright © 2018 WillJia. All rights reserved.
////
//
//import Foundation
//
//
//protocol SomeProtocol : InheritedProtocol1 , In2 {
//    var someProperty : Int {get set}
//    func aMethod (arg1: Double , anotherArg: String) -> someType
//    mutating func changeIt()
//    init(arg :Type)
//}
//
//// If Implement one protocol and mush imp every interited protocol
//// about var in protocol , mush specify get / set or both
//// marked mutating
//
//class someclass:SomeProtocol{
//    // implementation of some
//
//    required init(arg: Type) {
//
//    }
//
//    //  all subclass are required init
//}
//
//struct ss : SomeProtocol{
//
//}
//
//
//protocol Moveable {
//    mutating func move(to point)
//}
