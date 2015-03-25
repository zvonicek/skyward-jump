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
        self.addChild(opponent)
        
        MultiplayerManager.sharedInstance.comm.delegate = self
    }
    
    deinit {
        MultiplayerManager.sharedInstance.comm.delegate = nil
    }
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
        MultiplayerManager.sharedInstance.comm.sendMove(player.position, facingRight: player.facingRight)
    }
    
    // MARK: CommunicationDelegate
    func updateOpponentMove(point: CGPoint, facingRight: Bool) {
        println(point.x, point.y)
        opponent.position = point
        opponent.facingRight = facingRight
    }
    
    func matchEnded() {
        controllerDelegate?.dismissViewController()
    }
}