//
//  PlatformLayerNode.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 25.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class PlatformLayer: SKNode {
    
    init(world: World) {
        super.init()
        
        for platform in world.platforms {
            let sprite = CloudSprite(pos: platform.position, width: 50)
            self.addChild(sprite)
        }
        
        //Floor, so the character doesn't get lost
        let floor: CloudSprite = CloudSprite(pos: CGPoint(x: 0, y: 3), width: 640)
        floor.yScale = 1
        
        self.addChild(floor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}