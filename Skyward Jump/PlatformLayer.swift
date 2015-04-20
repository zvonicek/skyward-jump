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
        
        // create platforms to sprite
        for platform in world.platforms {
            let sprite = CloudSprite(pos: platform.position, width: platform.length, bounce: platform.bounce)
            self.addChild(sprite)
        }
        
        // create coins to sprite
        for coin in world.coins {
            let cSprite = CoinSprite(pos: coin.position)
            self.addChild(cSprite)
        }
        
        // create monsters to sprite
        for monster in world.monsters {
            let mSprite = MonsterSprite(pos: monster.position)
            mSprite.createMovement()
            self.addChild(mSprite)
        }
        
        //Floor, so the character doesn't get lost
        let floor = FloorSprite()
        
        self.addChild(floor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}