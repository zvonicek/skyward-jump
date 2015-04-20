//
//  Coin.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 19.04.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

class Coin: NSObject, NSCoding {
    
    var position: CGPoint
    let value: Int = 200
    
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