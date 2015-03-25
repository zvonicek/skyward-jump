//
//  CommunicationStrategy.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

typealias StartGameCallback = (world: World) -> Void

protocol CommunicationStrategy {
    var delegate: CommunicationDelegate? {get set}
    
    func authenticate(vc: UIViewController)
    func findMatch(vc: UIViewController, callback: StartGameCallback)
    func sendMove(point: CGPoint)
    func disconnect()
}

protocol CommunicationDelegate: class {
    func updateOpponentMove(point: CGPoint)
    func matchEnded()
}