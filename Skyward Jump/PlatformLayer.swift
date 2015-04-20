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
            let sprite = CloudSprite(pos: platform.position, width: platform.length)
            self.addChild(sprite)
        }
        
        //Floor, so the character doesn't get lost
        let floor = FloorSprite()
        
        self.addChild(floor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}