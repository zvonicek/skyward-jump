//
//  GameCenterCommunication.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation
import GameKit

class GameCenterCommunication: CommunicationStrategy, GameKitHelperDelegate {
    
    var viewController: UIViewController?
    var callback: Callback?
    weak var delegate: CommunicationDelegate?
    
    var sendPacketIndex:UInt16 = 0
    var receivedPacketIndex:UInt16 = 0
    
    init() {
        
    }
    
    // MARK: CommunicationStrategy
    
    func authenticate(vc: UIViewController) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAuthenticationViewController", name: PresentAuthenticationViewController, object: nil)
        viewController = vc
        
        GameKitHelper.sharedGameKitHelper().authenticateLocalPlayer()        
    }
    
    func findMatch(vc: UIViewController, callback: () -> Void) {
        self.callback = callback
        GameKitHelper.sharedGameKitHelper().findMatchWithMinPlayers(2, maxPlayers: 2, viewController: vc, delegate: self)
    }
    
    func sendMove(position: CGPoint) {
        sendPacketIndex++
        var message = MessageMove(messageType: .Move, position: position, index: sendPacketIndex)
        let data = NSData(bytes: &message, length: sizeof(MessageMove))
        self.sendData(data)
    }
    
    func disconnect() {
        
    }
    
    // MARK: GameKitHelperDelegate
    
    func matchStarted() {
        println("match started")
        if let callback = callback {
            callback()
        }        
    }
    
    func match(match: GKMatch, didReceiveData: NSData, fromPlayer: String) {
        println("receive data")
        let message = UnsafePointer<Message>(didReceiveData.bytes).memory
        
        switch (message.messageType) {
        case .Move:
            handleMoveMessage(match, data: didReceiveData, player: fromPlayer)
        default:
            println()
        }
    }
    
    func matchEnded() {
        println("match ended")
        delegate?.matchEnded()
    }
    
    // MARK: message extraction
    
    func handleMoveMessage(match: GKMatch, data: NSData, player: String) {
        let message = UnsafePointer<MessageMove>(data.bytes).memory
        if (message.index > receivedPacketIndex) {
            receivedPacketIndex = message.index
            delegate?.updateOpponentMove(message.position)
        }
    }
    
    // MARK: other methods
    
    func sendData(data: NSData) {
        var error: NSError?
        GameKitHelper.sharedGameKitHelper().match?.sendDataToAllPlayers(data, withDataMode: GKMatchSendDataMode.Reliable, error: &error)
        
        if (error != nil) {
            println("error")
        }
    }
    
    @objc func showAuthenticationViewController() {
        viewController?.presentViewController(GameKitHelper.sharedGameKitHelper().authenticationViewController, animated: true, completion: nil)
    }
}