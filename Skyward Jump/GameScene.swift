//
//  GameScene.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let player = SKSpriteNode(imageNamed: "pika.png")
    let testPlatform = SKSpriteNode(imageNamed: "platform.png")
    
    override func didMoveToView(view: SKView) {
        player.position = CGPointMake(50, 50)
        self.addChild(player)
        
        testPlatform.position = CGPointMake(100, 100);
        testPlatform.xScale = 0.5
        testPlatform.yScale = 0.5
        self.addChild(testPlatform)
        
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
