//
//  CollisionCategories.swift
//  Skyward Jump
//
//  Created by Kieu Nguyen on 20/03/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

struct Categories {
    
    static let WallCategory: UInt32 = 0x1 << 1
    static let PlatformCategory: UInt32 = 0x1 << 2
    static let FloorCategory: UInt32 = 0x1 << 3
    static let PlayerCatergory: UInt32 = 0x1 << 4
    static let NothingCategory: UInt32 = 0x1 << 5
   

    
}
