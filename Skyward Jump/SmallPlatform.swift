//
//  SmallPlatform.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.04.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

class SmallPlatform: Platform {
    override init(position: CGPoint) {
        super.init(position: position, length: 25, bounce: 400)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}