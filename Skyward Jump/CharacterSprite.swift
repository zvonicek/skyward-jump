//
//  CharacterSprite.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class CharacterSprite: SKSpriteNode {
    
    let sprite = SKSpriteNode(imageNamed: "hero")
    var facingRight = false
    
    func playerPhysics() {
        self.physicsBody?.dynamic = false
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(sprite.size.width, 10), center: CGPointMake(0, -sprite.size.height / 2))
        self.physicsBody?.dynamic = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.friction = 0.0
        self.physicsBody?.angularDamping = 0.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.mass = 1.0
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        self.physicsBody?.categoryBitMask = Category.Player
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = Category.Platform
    }
    
    func startPlayerDynamics() {
        self.physicsBody?.dynamic = true
    }
    
    func startPlayerImpulse() {
        self.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 100.0))
        println("First impulse")

    }
    
    func createPlayer(yPosition: CGFloat) -> SKNode {
        self.addChild(sprite)
        self.position = CGPoint(x: 50, y: yPosition)
        playerPhysics()
        
        return self
    }
    
    func flipFace() {
        self.runAction(SKAction.scaleXTo(self.xScale * -1, duration: 0.0))
        facingRight = !facingRight
    }
    

}