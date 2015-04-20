//
//  CoinSprite.swift
//  Skyward Jump
//
//  Created by Kieu Nguyen on 19/04/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class CoinSprite: SKSpriteNode {
    
    init(pos: CGPoint) {
        
        let coin = SKTexture(imageNamed: "coin")
        super.init(texture: coin, color: nil, size: coin.size())
        self.position = pos
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Category.Coin
        self.physicsBody?.collisionBitMask = 0
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
