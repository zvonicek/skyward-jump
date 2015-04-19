//
//  CoinSprite.swift
//  Skyward Jump
//
//  Created by Kieu Nguyen on 19/04/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class CoinSprite: SKSpriteNode {
    
    let coin = SKSpriteNode(imageNamed: "coin")
    
    
    func coinPhysics() {
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width)
        self.physicsBody?.dynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Category.Coin
        self.physicsBody?.collisionBitMask = 0
    }
    
    func createCoin() -> SKSpriteNode {
        
        self.addChild(coin)
        coinPhysics()
        //add position
        return self
        
    }
    
    
}
