//
//  Monster.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 20.04.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

class Monster: NSObject, NSCoding {
    
    var position: CGPoint
    
    init(position: CGPoint) {
        self.position = position
    }
    
    required init(coder aDecoder: NSCoder) {
        self.position = aDecoder.decodeCGPointForKey("pos")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeCGPoint(self.position, forKey: "pos")
    }
}