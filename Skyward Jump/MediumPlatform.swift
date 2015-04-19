//
//  MediumPlatform.swift
//  Skyward Jump
//
//  Created by Thea Christine Mathisen on 16/04/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//


class MediumPlatform: Platform {
    override init(position: CGPoint) {
        super.init(position: position, length: 2, bounce: 450)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}