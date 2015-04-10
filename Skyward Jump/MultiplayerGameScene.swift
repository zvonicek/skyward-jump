//
//  MultiplayerGameScene.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 18.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation
import SpriteKit

class MultiplayerGameScene: GameScene, CommunicationDelegate {
    
    let opponent = OpponentSprite()
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        platformLayer.addChild(opponent)
        
        MultiplayerManager.sharedInstance.comm.delegate = self
    }
    
    deinit {
        MultiplayerManager.sharedInstance.comm.delegate = nil
    }
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
        MultiplayerManager.sharedInstance.comm.sendMove(player.position, facingRight: player.facingRight)
    }
    
    override func die() {
        MultiplayerManager.sharedInstance.comm.sendMatchEnded(false)
        super.die()
    }
    
    override func quitGame() {
        MultiplayerManager.sharedInstance.comm.sendMatchEnded(false)
        super.quitGame()
    }
    
    // MARK: CommunicationDelegate
    func updateOpponentMove(point: CGPoint, facingRight: Bool) {
        opponent.position = point
        opponent.facingRight = facingRight
    }
    
    func lostConnection() {
        //TODO: show status message
        println("lost connection")
        controllerDelegate?.dismissViewController()
    }
    
    func gameOver(won: Bool) {
        //TODO: show result
        println("game over, won: ", won)
        controllerDelegate?.dismissViewController()
    }
}