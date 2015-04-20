//
//  WorldFactory.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 19.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//
//
/* Note, there are three types of platform array.
1.Fixed path, the platforms that lead to the next level.
2.Extra path, the extra platforms that help the player has easier paths to jump on.
3.Void path, this path presents the broken platform.
*/

import Foundation

// Constants
let jumpHeight = 140
let platformHeight = 50
let platformWidth = 100
let numberOfMonster = 15

class WorldFactory {
    
    var fixedPath: [Platform] = []
    var extraPath: [Platform] = []
    var voidPath: [Platform] = []
    var coins: [Coin] = []
    var monsters: [Monster] = []
    var levelHeight: Int?
    let numberOfPlatform: Int
    
    
    init() {
        self.levelHeight = 7300
        numberOfPlatform = (self.levelHeight! / jumpHeight)
        
        createFixedPath()
        createExtraPath()
        createVoidPath()
        createCoin()
        createMonster()
    }
    
    func createMonster() {
        let height = self.levelHeight! / numberOfMonster
        for (var i = 0; i < numberOfPlatform; i++ ){
            var positionY = height * (i + 1)
            var positionX = randomPositionX()
            
            var position = CGPointMake(CGFloat(positionX), CGFloat(positionY))
            var m = Monster(position: position)
            self.monsters.append(m)
        }
    }
    
    func createCoin() {
        for platform in fixedPath {
            var ppos = platform.position
            let x = ppos.x
            let y = ppos.y + 20
            var pos:CGPoint = CGPointMake(x, y)
            let coin = Coin(position: pos)
            
            if (arc4random_uniform(2) + 1) == 1 {
                self.coins.append(coin)
            }
        }
    }
    
    func createVoidPath() {
        ///////// need to have a different type of platform //////////
        for var i = 0; i < numberOfPlatform; i++ {
            if i > 21 {
                let amount = 1
                
                let randomAmount = randomPlatformFrom(amount)
                
                // create platform from amount
                for var k = 0; k < randomAmount; k++ {
                    if randomAmount == 1 {
                        var positionY = randomLowerUpper(i)
                        var positionX = randomPositionX()
                        let position = CGPointMake(CGFloat(positionX), CGFloat(positionY))
                        var p = Platform(position: position)
                        self.voidPath.append(p)
                        
                    } else {
                        var positionX = randomPositionX()
                        for var j = 0; j < randomAmount; j++ {
                            var positionY = randomLowerUpper(i)
                            var x = positionX
                            let position = CGPointMake(CGFloat(x), CGFloat(positionY))
                            var p = Platform(position: position)
                            self.voidPath.append(p)
                            
                            positionX += Float((platformWidth / 2) + randomDistanceFromEachPlatform())
                        }
                    }
                }
            }
        }
    }
    
    func createExtraPath() {
        // random amount of platform relate to height by numberOfPlatform.
        for var i = 0; i < numberOfPlatform; i++ {
            if i >= 0 && i < 10 {
                let amount = 3
                let randomAmount = randomPlatformFrom(amount)
                
                // create platform from amount
                for var k = 0; k < randomAmount; k++ {
                    if randomAmount == 1 {
                        var positionY = randomLowerUpper(i)
                        var positionX = randomPositionX()
                        let position = CGPointMake(CGFloat(positionX), CGFloat(positionY))
                        var p = Platform(position: position)
                        self.extraPath.append(p)
                        
                    } else if randomAmount == 2 {
                        var positionX = randomPositionX()
                        for var j = 0; j < randomAmount; j++ {
                            var positionY = randomLowerUpper(i)
                            var x = positionX
                            let position = CGPointMake(CGFloat(x), CGFloat(positionY))
                            var p = Platform(position: position)
                            self.extraPath.append(p)
                            
                            positionX += Float((platformWidth / 2) + randomDistanceFromEachPlatform())
                        }
                    } else {
                        var positionX = randomPositionX()
                        for var j = 0; j < randomAmount; j++ {
                            var positionY = randomLowerUpper(i)
                            var x = positionX
                            let position = CGPointMake(CGFloat(x), CGFloat(positionY))
                            var p = Platform(position: position)
                            self.extraPath.append(p)
                            
                            positionX += Float((platformWidth / 2) + randomDistanceFromEachPlatform())
                        }
                    }
                }
            } else if i >= 10 && i < 28 {
                let amount = 2
                
                let randomAmount = randomPlatformFrom(amount)
                
                // create platform from amount
                for var k = 0; k < randomAmount; k++ {
                    if randomAmount == 1 {
                        var positionY = randomLowerUpper(i)
                        var positionX = randomPositionX()
                        let position = CGPointMake(CGFloat(positionX), CGFloat(positionY))
                        var p = Platform(position: position)
                        self.extraPath.append(p)
                        
                    } else {
                        var positionX = randomPositionX()
                        for var j = 0; j < randomAmount; j++ {
                            var positionY = randomLowerUpper(i)
                            var x = positionX
                            let position = CGPointMake(CGFloat(x), CGFloat(positionY))
                            var p = Platform(position: position)
                            self.extraPath.append(p)
                            
                            positionX += Float((platformWidth / 2) + randomDistanceFromEachPlatform())
                        }
                    }
                }
            } else if i >= 28 {
                let amount = 1
                let randomAmount = randomPlatformFrom(amount)
                
                // create platform from amount
                for var k = 0; k < randomAmount; k++ {
                    if randomAmount == 1 {
                        var positionY = randomLowerUpper(i)
                        var positionX = randomPositionX()
                        let position = CGPointMake(CGFloat(positionX), CGFloat(positionY))
                        var p = Platform(position: position)
                        self.extraPath.append(p)
                        
                    } else {
                        var positionX = randomPositionX()
                        for var j = 0; j < randomAmount; j++ {
                            var positionY = randomLowerUpper(i)
                            var x = positionX
                            let position = CGPointMake(CGFloat(x), CGFloat(positionY))
                            var p = Platform(position: position)
                            self.extraPath.append(p)
                            
                            positionX += Float((platformWidth / 2) + randomDistanceFromEachPlatform())
                        }
                    }
                }
            }
        }
    }
    
    func createFixedPath() {
        for (var i = 0; i < numberOfPlatform; i++ ){
            var positionY = jumpHeight * (i + 1)
            var positionX = randomPositionX()
            
            var position = CGPointMake(CGFloat(positionX), CGFloat(positionY))
            var p = Platform(position: position)
            self.fixedPath.append(p)
        }
    }
    
    func randomDistanceFromEachPlatform() -> Int {
        return 10//Int(arc4random_uniform(30) + 5)
    }
    
    func randomLowerUpper(i: Int) -> Int {
        var positionY: Int
        let r = arc4random_uniform(100) + 1
        if r % 2 == 0 {
            // upper
            positionY = (jumpHeight * (i + 1)) + platformHeight + randomDistanceFromEachPlatform()
            
        } else {
            // lower
            positionY = (jumpHeight * (i + 1)) - platformHeight - randomDistanceFromEachPlatform()
        }
        return positionY
    }
    
    func randomPositionX() -> Float {
        return Float(arc4random_uniform(320))
    }
    
    func randomPlatformFrom(amount:Int) -> Int {
        return Int(arc4random_uniform(UInt32(amount)) + 1)
    }
    
    
    func generateWorld() -> World {
        var platforms = self.fixedPath
        platforms += self.extraPath
        platforms += self.voidPath
        var coins = self.coins
        var monsters = self.monsters
        var w = World(platforms: platforms, coins: coins, monsters: monsters)
        return w
    }
    
    
}