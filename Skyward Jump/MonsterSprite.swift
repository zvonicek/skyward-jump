//
//  MonsterSprite.swift
//  Skyward Jump
//
//  Created by Keangping on 19/04/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class MonsterSprite: SKSpriteNode {
    
   
    init(pos: CGPoint) {
        
        let mon = SKTexture(imageNamed: "monster")
        super.init(texture: mon, color: nil, size: mon.size())
        self.position = pos
        self.physicsBody = SKPhysicsBody(texture: mon, size: self.size)
        self.physicsBody?.dynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = Category.Monster
        self.physicsBody?.collisionBitMask = 0
        
    }
    
    func createMovement() {
        var x = self.position.x
        var y = self.position.y + 20
        var pos = CGPointMake(x, y)
        var actions: [SKAction] = []
        var action1 = SKAction.moveTo(pos, duration: 0.7)
        var pos2 = CGPointMake(x, y-20)
        var action2 = SKAction.moveTo(pos2, duration: 0.7)
        
        actions.append(action1)
        actions.append(action2)
        
        let generateMovement = SKAction.sequence(actions)
        let loopMovement = SKAction.repeatActionForever(generateMovement)
        self.runAction(loopMovement)

        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
