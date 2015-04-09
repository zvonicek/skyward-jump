//
//  OpponentSprite.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 25.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class OpponentSprite: SKSpriteNode {
    
    var facingRight: Bool = false {
        willSet(newFacing) {
            if facingRight != newFacing {
                self.runAction(SKAction.scaleXTo(self.xScale * -1, duration: 0.0))
            }
        }
    }
    
    override init() {
        let texture = SKTexture(imageNamed: "meow")
        super.init(texture: texture, color: nil, size: texture.size())
        self.position = CGPoint(x: 50, y: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
