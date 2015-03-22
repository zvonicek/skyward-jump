//
//  GameScene.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    //Sprites to add to the scene
    let player: CharacterSprite = CharacterSprite() //create a player node
    let platform: CloudSprite = CloudSprite() //create a platform node
    let platform2: CloudSprite = CloudSprite() //2nd platform node
    //    let platform3: PlatformSprite = PlatformSprite() //3rd platform node
    
    //Controll attributes
    var touched: Bool = false
    
    
    //Start location of the player
    var location = CGPointMake(50, 50)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        
        //Adds gravity to the y-direction
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -4.0)
        //Add contact delegate
        physicsWorld.contactDelegate = self
        
        player.createPlayer()
        platform.createPlatforms(CGPoint(x: 200, y: 100))
        platform2.createPlatforms(CGPoint(x: 50, y: 200))
        //        platform3.createPlatforms(CGPoint(x: 200, y: 350))
        
        
    }
    
    override func didMoveToView(view: SKView) {
        self.addChild(player)
        self.addChild(platform)
        self.addChild(platform2)
        //        self.addChild(platform3)
    }
    
    func collisionDetected() {
        
        player.physicsBody?.applyForce(CGVector(dx: 0.0, dy: 50.0))
        println("Force applied")
        
    }
    
    //Function get automatically called when to bodies are in contact
    func didBeginContact(contact: SKPhysicsContact) {
        
        //The body with the lower category are stored as the firstBody
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
            
        }
        
        /*Not behaving right, should only detect collison when player is moving downward...*/
        //React to contact between player and platform, and check if velocity y direction is < 0, which
        //means it is moving downwards. Should only collide downwards.
        if (firstBody.categoryBitMask == Category.playerCategory && secondBody.categoryBitMask == Category.platformCategory && player.physicsBody?.velocity.dy < 0) {
            println("Collision with platform")
            
            collisionDetected() //This is not called, but no force are applied
            
            
        }
        
        //TODO:
        //if: check if collision with floor, move over to GameOver Scene
        //if: check if collision with wall, move through wall to other side
        
    }
    
    
    //Touch anywhere on the screen, and the game starts. Setting dynamics to true and adds initial upwards impulse
    //to the player.
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        //move node to touch location
        touched = true
        for touch: AnyObject in touches {
            location = touch.locationInNode(self)
            player.startPlayerDynamics()
            player.startPlayerImpulse()
            
        }
        
        player.startPlayerDynamics()
        player.startPlayerImpulse()
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        //update node to touch loaction
        for touch: AnyObject in touches {
            location = touch.locationInNode(self)
        }
    }
    
    //Function for moving from one position to a touch position. Scale to speed movement.
    func moveToPosition() {
        let speed = 0.1 as CGFloat
        var dx = location.x - player.position.x
        var dy = location.y - player.position.y
        dx = dx * speed
        dy = dy * speed
        
        //new position of player updated here
        player.position = CGPointMake(player.position.x + dx, player.position.y + dy)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if(touched) {
            moveToPosition()
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        touched = false
        
    }
    
    
}
