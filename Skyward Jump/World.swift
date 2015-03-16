//
//  World.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

class World: NSCoding {
    var clouds = [CloudSprite]()
    
    // MARK: NSCoding
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.clouds = aDecoder.decodeObjectForKey("clouds") as [CloudSprite]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.clouds, forKey: "clouds")
    }
    
    // MARK: 
    
    init() {
        
    }
}
