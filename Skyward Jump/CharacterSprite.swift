//
//  CharacterSprite.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class CharacterSprite: SKNode {
    
    let playerSprite = SKSpriteNode(imageNamed: "pika.png")
    
    
    func playerPhysics() {
        
        //playerSprite.physicsBody = SKPhysicsBody(circleOfRadius: playerSprite.size.width / 2)
        playerSprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "pika"), size: playerSprite.size)
        playerSprite.physicsBody?.dynamic = false
        playerSprite.physicsBody?.allowsRotation = false
        playerSprite.physicsBody?.restitution = 1.0 //makes it bounce
        playerSprite.physicsBody?.friction = 0.0
        playerSprite.physicsBody?.angularDamping = 0.0
        playerSprite.physicsBody?.linearDamping = 0.0
        playerSprite.physicsBody?.mass = 1.0
        playerSprite.physicsBody?.usesPreciseCollisionDetection = true
        
        playerSprite.physicsBody?.categoryBitMask = Category.playerCategory // category
        playerSprite.physicsBody?.collisionBitMask =  Category.platformCategory | Category.floorCategory | Category.wallCategory //what type of collision it can have
        playerSprite.physicsBody?.contactTestBitMask = Category.platformCategory | Category.floorCategory | Category.wallCategory //inform when these type of collision occurs
        
    }
    
    func startPlayerDynamics() {
        playerSprite.physicsBody?.dynamic = true
        
    }
    
    func startPlayerImpulse() {
        playerSprite.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 30.0))
        println("Given initial impulse")

    }
    
    func createPlayer() -> SKNode {
        
        playerSprite.position = CGPointMake(50, 50)
        playerPhysics()
        self.addChild(playerSprite)
        
        return playerSprite
        
    }

    

}