//
//  MultipeerCommunication.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 09.04.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation
import MultipeerConnectivity

enum State {
    case Stopped, ServerWaiting, ClientWaiting, Running
}

class MultipeerCommunication: NSObject, CommunicationStrategy, MCBrowserViewControllerDelegate, MCSessionDelegate, MCAdvertiserAssistantDelegate {
    
    let session: MCSession = MCSession(peer: MCPeerID(displayName: UIDevice.currentDevice().name))
    var assistant: MCAdvertiserAssistant?
    var browserVC: MCBrowserViewController?
    
    weak var delegate: CommunicationDelegate?
    var callback: StartGameCallback?
    var state = State.Stopped
    
    var sendPacketIndex:UInt16 = 0
    var receivedPacketIndex:UInt16 = 0
    
    override init() {
        super.init()
        
        session.delegate = self
    }
    
    func authenticate(vc: UIViewController, callback: StartGameCallback) {
        self.state = State.ServerWaiting
        self.callback = callback
        
        assistant = MCAdvertiserAssistant(serviceType: "io-objc-mpc", discoveryInfo: nil, session: session)
        assistant!.delegate = self
        assistant!.start()
    }
    
    func findMatch(vc: UIViewController, callback: StartGameCallback)
    {
        if let assistant = assistant {
            assistant.stop()
        }
        
        self.state = State.ClientWaiting
        self.callback = callback
        
        let serviceType = "io-objc-mpc" // Limited to 15 ASCII characters
        let browserVC = MCBrowserViewController(serviceType: serviceType, session: session)
        browserVC.delegate = self
        browserVC.maximumNumberOfPeers = 2
        browserVC.minimumNumberOfPeers = 2
        vc.presentViewController(browserVC, animated: true) { () -> Void in
        }
        
        self.browserVC = browserVC
    }
    
    func sendMove(position: CGPoint, facingRight: Bool)
    {
        sendPacketIndex++
        var message = MessageMove(messageType: .Move, pos_x: Float(position.x), pos_y: Float(position.y), index: sendPacketIndex,
            facingRight: ObjCBool(facingRight))
        let data = NSData(bytes: &message, length: sizeof(MessageMove))
        self.sendData(data, reliable: false)
    }
    
    func sendMatchEnded(won: Bool)
    {
        var message = MessageGameOver(messageType: .GameOver, senderWon: ObjCBool(won))
        let data = NSData(bytes: &message, length: sizeof(MessageGameOver))
        self.sendData(data, reliable: true)
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
        
        self.state == State.Running        
        callback!(world: world)
        
        self.sendData(data, reliable: true)
    }
    
    func sendData(data: NSData, reliable: Bool) {
        var error: NSError?
        let dataMode = reliable ? MCSessionSendDataMode.Reliable : MCSessionSendDataMode.Unreliable
        
        self.session.sendData(data, toPeers: self.session.connectedPeers, withMode: dataMode, error: &error)
        
        if (error != nil) {
            println("error")
        }
    }
    
    // MARK: MCBrowserViewControllerDelegate
    
    @objc func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        browserViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewController(browserViewController: MCBrowserViewController!, shouldPresentNearbyPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) -> Bool {
        return true
    }
    
    // MARK: MCSessionDelegate
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
        if (state == MCSessionState.Connected) {
            browserVC?.dismissViewControllerAnimated(true, completion: nil)
            println("connected")
            
            if (self.state == State.ServerWaiting) {
                self.negotiateWorld()
            }

        } else if (state == MCSessionState.Connecting) {
            println("connecting")
        }
        
        println(self.session.connectedPeers)
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
        let message = UnsafePointer<Message>(data.bytes).memory
        
        switch (message.messageType) {
        case .NegotiateWorld:
            handleNegotiateWorldMessage(data)
        case .Move:
            handleMoveMessage(data)
        case .GameOver:
            handleGameOverMessage(data)
        default:
            println()
        }
        
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
        // unused
    }
    
    func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
        // unused
    }
    
    func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
        
    }
    
    // MARK: message extraction
    
    func handleNegotiateWorldMessage(data: NSData) {
        let message = UnsafePointer<MessageNegotiateWorld>(data.bytes).memory
        let worldData = data.subdataWithRange(NSMakeRange(sizeof(MessageNegotiateWorld), data.length - sizeof(MessageNegotiateWorld)))
        let world = NSKeyedUnarchiver.unarchiveObjectWithData(worldData) as! World
        
        if let callback = callback {
            self.state == State.Running
            callback(world: world)
        }
    }
    
    func handleMoveMessage(data: NSData) {
        let message = UnsafePointer<MessageMove>(data.bytes).memory
        if (message.index > receivedPacketIndex) {
            receivedPacketIndex = message.index
            delegate?.updateOpponentMove(CGPointMake(CGFloat(message.pos_x), CGFloat(message.pos_y)), facingRight: message.facingRight.boolValue)
        }
    }
    
    func handleGameOverMessage(data: NSData) {
        let message = UnsafePointer<MessageGameOver>(data.bytes).memory
        delegate?.gameOver(Bool(!message.senderWon))
    }
}
