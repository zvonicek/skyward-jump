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
    var callback: StartGameCallback?
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
    
    func findMatch(vc: UIViewController, callback: StartGameCallback) {
        self.callback = callback
        GameKitHelper.sharedGameKitHelper().findMatchWithMinPlayers(2, maxPlayers: 2, viewController: vc, delegate: self)
    }
    
    func negotiateWorld() {
        let platform1 = Platform(position: CGPointMake(10, 10), length: 10.0)
        let platform2 = Platform(position: CGPointMake(20, 20), length: CGFloat(Int(rand()) % 100))
        let world = World(platforms: [platform1, platform2])
        let worldData = NSKeyedArchiver.archivedDataWithRootObject(world)
            
        var message = MessageNegotiateWorld(messageType: MessageType.NegotiateWorld, randomNumber: arc4random())
        
        let data = NSMutableData()
        data.appendData(NSData(bytes: &message, length: sizeof(MessageNegotiateWorld)))
        data.appendData(worldData)
        
        self.sendData(data, reliable: true)
    }
    
    func sendMove(position: CGPoint, facingRight: Bool) {
        sendPacketIndex++
        var message = MessageMove(messageType: .Move, pos_x: Float(position.x), pos_y: Float(position.y), index: sendPacketIndex,
            facingRight: ObjCBool(facingRight))
        let data = NSData(bytes: &message, length: sizeof(MessageMove))
        self.sendData(data, reliable: false)
    }
    
    func sendMatchEnded(won: Bool) {
        var message = MessageGameOver(messageType: .GameOver, senderWon: ObjCBool(won))
        let data = NSData(bytes: &message, length: sizeof(MessageGameOver))
        self.sendData(data, reliable: true)
    }
    
    // MARK: GameKitHelperDelegate
    
    @objc func matchStarted() {
        println("match started")
        self.negotiateWorld()
    }
    
    @objc func match(match: GKMatch, didReceiveData: NSData, fromPlayer: String) {
        let message = UnsafePointer<Message>(didReceiveData.bytes).memory
        
        switch (message.messageType) {
        case .NegotiateWorld:
            handleNegotiateWorldMessage(match, data: didReceiveData, player: fromPlayer)
        case .Move:
            handleMoveMessage(match, data: didReceiveData, player: fromPlayer)
        case .GameOver:
            handleGameOverMessage(match, data: didReceiveData, player: fromPlayer)
        default:
            println()
        }
    }
    
    @objc func matchEnded() {
        println("match ended")
        delegate?.lostConnection()
    }
    
    // MARK: message extraction
    
    func handleNegotiateWorldMessage(match: GKMatch, data: NSData, player: String) {
        let message = UnsafePointer<MessageNegotiateWorld>(data.bytes).memory
        let worldData = data.subdataWithRange(NSMakeRange(sizeof(MessageNegotiateWorld), data.length - sizeof(MessageNegotiateWorld)))
        let world = NSKeyedUnarchiver.unarchiveObjectWithData(worldData) as! World
        
        if let callback = callback {
            callback(world: world)
        }
    }
    
    func handleMoveMessage(match: GKMatch, data: NSData, player: String) {
        let message = UnsafePointer<MessageMove>(data.bytes).memory
        if (message.index > receivedPacketIndex) {
            receivedPacketIndex = message.index
            delegate?.updateOpponentMove(CGPointMake(CGFloat(message.pos_x), CGFloat(message.pos_y)), facingRight: message.facingRight.boolValue)
        }
    }
    
    func handleGameOverMessage(match: GKMatch, data: NSData, player: String) {
        let message = UnsafePointer<MessageGameOver>(data.bytes).memory
        delegate?.gameOver(Bool(!message.senderWon))
    }
    
    // MARK: other methods
    
    func sendData(data: NSData, reliable: Bool) {
        var error: NSError?
        let dataMode = reliable ? GKMatchSendDataMode.Reliable : GKMatchSendDataMode.Unreliable
        GameKitHelper.sharedGameKitHelper().match?.sendDataToAllPlayers(data, withDataMode: dataMode, error: &error)
        
        if (error != nil) {
            println("error")
        }
    }
    
    @objc func showAuthenticationViewController() {
        viewController?.presentViewController(GameKitHelper.sharedGameKitHelper().authenticationViewController, animated: true, completion: nil)
    }
}