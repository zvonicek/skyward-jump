//
//  CloudSprite.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class CloudSprite: SKNode {
    
    let platformSprite = SKSpriteNode(imageNamed: "platform.png")
    
    func platformPhysics() {
        
        
        //platformSprite.physicsBody = SKPhysicsBody(rectangleOfSize: platformSprite.size)
        platformSprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "platform"), size: platformSprite.size)
        platformSprite.physicsBody?.dynamic = false
        platformSprite.physicsBody?.usesPreciseCollisionDetection = true
        platformSprite.physicsBody?.friction = 0.0
        platformSprite.physicsBody?.linearDamping = 0.0
        
        platformSprite.physicsBody?.categoryBitMask = Category.platformCategory
        platformSprite.physicsBody?.contactTestBitMask = 0
        
        
    }
    
    
    //Should be able to create multiple platforms
    //Function only create 1 platform at a fixed posistion
    func createPlatforms(pos: CGPoint) -> SKNode {
        
        let posOnScene = CGPoint(x: pos.x, y: pos.y)
        platformSprite.position = posOnScene
        platformSprite.xScale = 0.5
        platformSprite.yScale = 0.5
        platformPhysics()
        
        self.addChild(platformSprite)
        
        return platformSprite
        
    }
    

   
}