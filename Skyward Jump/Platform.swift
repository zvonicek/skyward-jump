//
//  Platform.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 19.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

class Platform: NSObject, NSCoding {
    
    var position: CGPoint
    var length: CGFloat
    var bounce: Int
    
    init(position: CGPoint, length: CGFloat, bounce: Int) {
        self.position = position
        self.length = length
        self.bounce = bounce
    }
    
    init(position: CGPoint, length: CGFloat) {
        self.position = position
        self.length = length
        self.bounce = 300
    }
    
    init(position: CGPoint) {
        self.position = position
        self.length = 75
        self.bounce = 300
    }
    
    required init(coder aDecoder: NSCoder) {
        self.position = aDecoder.decodeCGPointForKey("pos")
        self.length = CGFloat(aDecoder.decodeFloatForKey("len") as Float)
        self.bounce = aDecoder.decodeIntegerForKey("bounce")
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeCGPoint(self.position, forKey: "pos")
        aCoder.encodeFloat(Float(length), forKey: "len")
        aCoder.encodeInteger(bounce, forKey: "bounce")
    }
}