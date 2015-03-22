//
//  CloudSprite.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class CloudSprite: SKNode {
    
    let sprite = SKSpriteNode(imageNamed: "platform.png")
    
    func platformPhysics(scale: CGFloat) {
        let scaledSize = CGSize(width: scale * sprite.size.width, height: scale * sprite.size.height)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: scaledSize)
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = Category.Platform
        self.physicsBody?.collisionBitMask = 0
    }
    
    
    //Should be able to create multiple platforms
    //Function only create 1 platform at a fixed posistion
    func createPlatform(pos: CGPoint, scale: CGFloat) -> SKNode {
        self.addChild(sprite)
        self.position = pos
        self.xScale = scale
        self.yScale = scale
        platformPhysics(scale)
        
        return self
    }
    

   
}