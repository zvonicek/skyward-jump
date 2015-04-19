//
//  CloudSprite.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class CloudSprite: SKSpriteNode {
    init(pos: CGPoint, width: CGFloat) {
        super.init(texture: nil, color: UIColor(red: 219/255.0, green: 235/255.0, blue: 195/255.0, alpha: 1.0), size: CGSize(width: width, height: 10))
        
        let border = SKShapeNode(rectOfSize: self.size)
        border.lineWidth = 2
        border.strokeColor = UIColor(red: 41/255.0, green: 104/255.0, blue: 121/255.0, alpha: 1.0)
        self.addChild(border)
        
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