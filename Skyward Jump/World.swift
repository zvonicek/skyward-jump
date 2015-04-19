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
    
    init(platforms: [Platform]) {
        self.platforms = platforms
    }
    
    required init(coder aDecoder: NSCoder) {
        self.platforms = aDecoder.decodeObjectForKey("pl") as! [Platform]
        self.coins = aDecoder.decodeObjectForKey("c") as! [Coin]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.platforms, forKey: "pl")
        aCoder.encodeObject(self.coins, forKey: "c")
    }
}