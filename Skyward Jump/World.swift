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
    
    init(platforms: [Platform]) {
        self.platforms = platforms
    }
    
    required init(coder aDecoder: NSCoder) {
        self.platforms = aDecoder.decodeObjectForKey("pl") as! [Platform]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.platforms, forKey: "pl")
    }
}