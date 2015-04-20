//
//  World.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

class World: NSObject, NSCoding {
    
    var platforms: [Platform] = []
    var coins: [Coin] = []
    var monsters: [Monster] = []
    
    
    init(platforms: [Platform], coins: [Coin], monsters: [Monster]) {
        self.platforms = platforms
    }
    
    required init(coder aDecoder: NSCoder) {
        self.platforms = aDecoder.decodeObjectForKey("pl") as! [Platform]
        self.coins = aDecoder.decodeObjectForKey("c") as! [Coin]
        self.monsters = aDecoder.decodeObjectForKey("m") as! [Monster]        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.platforms, forKey: "pl")
        aCoder.encodeObject(self.coins, forKey: "c")
        aCoder.encodeObject(self.monsters, forKey: "m")
    }
}