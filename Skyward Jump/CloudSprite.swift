//
//  CloudSprite.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class CloudSprite: SKSpriteNode {
    
    var bounce: Int = 300
    
    init(pos: CGPoint, width: CGFloat, bounce: Int) {
        let image: NSString
        if width < 50 {
            image = "platform_small"
        } else if width == 50 {
            image = "platform_medium"
        } else {
            image = "platform_big"
        }
        
        let texture = SKTexture(imageNamed: image as String)
        super.init(texture: texture, color: nil, size: texture.size())
        self.bounce = bounce
        
        self.position = pos
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