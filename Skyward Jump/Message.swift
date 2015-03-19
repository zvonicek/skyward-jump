//
//  Message.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 18.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

enum MessageType: UInt32 {
    case GameBegin, Move, GameOver
}

protocol MessageProtocol {
    var messageType: MessageType {get set}
}

struct Message: MessageProtocol {
    var messageType: MessageType
}

struct MessageGameBegin: MessageProtocol {
    var messageType: MessageType
}

struct MessageGameOver: MessageProtocol {
    var messageType: MessageType
    var playerWon: UInt32
}

struct MessageMove: MessageProtocol {
    var messageType: MessageType
    var position: CGPoint
    var index: UInt16
}