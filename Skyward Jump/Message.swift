//
//  Message.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 18.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

enum MessageType: UInt32 {
    case NegotiateWorld, Move, GameOver
}

protocol MessageProtocol {
    var messageType: MessageType {get set}
}

struct Message: MessageProtocol {
    var messageType: MessageType    
}

struct MessageNegotiateWorld: MessageProtocol {
    var messageType = MessageType.NegotiateWorld
    var randomNumber: UInt32
}

struct MessageGameOver: MessageProtocol {
    var messageType = MessageType.GameOver
    var score: UInt32
    var senderInterrupted: ObjCBool
}

struct MessageMove: MessageProtocol {
    var messageType = MessageType.Move
    var pos_x: Float
    var pos_y: Float
    var index: UInt16 //packet index
//    var score: UInt16
    var facingRight: ObjCBool
}