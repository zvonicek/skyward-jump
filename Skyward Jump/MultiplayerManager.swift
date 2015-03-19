//
//  MultiplayerManager.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

class MultiplayerManager {
    
    var comm: CommunicationStrategy
    
    class var sharedInstance : MultiplayerManager {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : MultiplayerManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = MultiplayerManager()
        }
        return Static.instance!
    }
        
    init() {
        comm = GameCenterCommunication()
    }    
}