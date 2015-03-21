//
//  CollisionCategories.swift
//  Skyward Jump
//
//  Created by Kieu Nguyen on 20/03/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

struct Category {
    
    static let playerCategory: UInt32 = 0x1 << 1
    static let platformCategory: UInt32 = 0x1 << 2
    static let floorCategory: UInt32 = 0x1 << 3
    static let wallCategory: UInt32 = 0x1 << 4
   

    
}
