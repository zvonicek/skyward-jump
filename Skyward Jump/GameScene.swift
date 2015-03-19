//
//  GameScene.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var character: CharacterSprite!
    weak var controllerDelegate: GameViewControllerDelegate?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        
        character = CharacterSprite()
        character.xScale = 0.5
        character.yScale = 0.5
        character.position = CGPointMake(500, 500)
        
        let action = SKAction.sequence([
            SKAction.moveByX(100, y: 0, duration: 1),
            SKAction.moveByX(-100, y: 0, duration: 1),
            ])
        
        character.runAction(SKAction.repeatActionForever(action))
        self.addChild(character)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        self.paused = !self.paused
        
        if (self.paused) {
            println("paused")
        } else {
            println("resumed")
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
