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
    
    init(position: CGPoint, length: CGFloat) {
        self.position = position
        self.length = length
    }
    
    init(position: CGPoint) {
        self.position = position
        self.length = 20
    }
    
    required init(coder aDecoder: NSCoder) {
        self.position = aDecoder.decodeCGPointForKey("pos")
        self.length = CGFloat(aDecoder.decodeFloatForKey("len") as Float)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeCGPoint(self.position, forKey: "pos")
        aCoder.encodeFloat(Float(length), forKey: "len")
    }
}