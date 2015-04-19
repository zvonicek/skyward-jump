//
//  BigPlatform.swift
//  Skyward Jump
//
//  Created by Thea Christine Mathisen on 16/04/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

class BigPlatform: Platform {
    override init(position: CGPoint) {
        super.init(position: position, length: 3, bounce: 300)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}