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
    var opponent: CharacterSprite!

    override init() {
        super.init()
    }
    
    override init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        opponent = CharacterSprite()
        opponent.xScale = 0.2
        opponent.yScale = 0.2
        opponent.position = CGPointMake(400, 400)

        self.addChild(opponent)
        
        MultiplayerManager.sharedInstance.comm.delegate = self
    }
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
        
        MultiplayerManager.sharedInstance.comm.sendMove(character.position)
    }
    
    // MARK: CommunicationDelegate
    
    func updateOpponentMove(point: CGPoint) {
        println(point.x, point.y)
        opponent.position = point
    }
    
    func matchEnded() {
        
    }
}