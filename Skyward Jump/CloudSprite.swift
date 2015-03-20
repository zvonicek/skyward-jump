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
    
    
    //Adds physics to platforms
    func platformPhysics() {
        
        
        platformSprite.physicsBody = SKPhysicsBody(rectangleOfSize: platformSprite.size)
        platformSprite.physicsBody?.dynamic = false
        
        platformSprite.physicsBody?.categoryBitMask = Categories.PlatformCategory
        platformSprite.physicsBody?.collisionBitMask = Categories.PlatformCategory
        
    }
    
   
    //Function only create 1 platform at a fixed posistion
    func createPlatforms() -> SKNode {
        
        platformSprite.position = CGPointMake(200, 100);
        platformSprite.xScale = 0.5
        platformSprite.yScale = 0.5
        platformPhysics()
        
        self.addChild(platformSprite)
        
        return platformSprite
        
    }
    

   
}