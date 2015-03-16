//
//  CommunicationStrategy.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation

protocol CommunicationStrategy {
    func findMatch()
    func sendData(data: NSData)
    func disconnect()
}