//
//  FloorSprite.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 17.04.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class FloorSprite: SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "floor")
        super.init(texture: texture, color: nil, size: texture.size())
        self.position = CGPoint(x: 0, y: 10)
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Category.Platform
        self.physicsBody?.collisionBitMask = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
