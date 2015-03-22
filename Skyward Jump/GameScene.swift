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
    
    //Floor, so the character doesn't get lost
    let floor: CloudSprite = CloudSprite()
    
    //Controll attributes
    var firstTouch = true
    
    //Sound effects
    let bounceSound = SKAction.playSoundFileNamed("bounce.mp3", waitForCompletion: false);
    
    //Start location of the player
    var location = CGPointMake(50, 50)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        
        //Adds gravity to the y-direction
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        //Add contact delegate
        physicsWorld.contactDelegate = self
        
        player.createPlayer()
        platform.createPlatform(CGPoint(x: 200, y: 100), scale: CGFloat(0.5))
        platform2.createPlatform(CGPoint(x: 50, y: 200), scale: CGFloat(0.5))
        floor.createPlatform(CGPoint(x: 300, y: 0), scale: 5)
        floor.yScale = 1
    }
    
    override func didMoveToView(view: SKView) {
        self.addChild(platform)
        self.addChild(platform2)
        self.addChild(floor)
        self.addChild(player)
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
        
        if (firstBody.categoryBitMask == Category.Player && secondBody.categoryBitMask == Category.Platform && player.physicsBody?.velocity.dy < 0) {
            println("Collision with platform")
            runAction(bounceSound)
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 300.0)
        }
        
        //TODO:
        //if: check if collision with floor, move over to GameOver Scene
        //if: check if collision with wall, move through wall to other side
        
    }
    
    
    //Touch anywhere on the screen, and the game starts. Setting dynamics to true and adds initial upwards impulse
    //to the player.
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if firstTouch {
            player.startPlayerDynamics()
            player.startPlayerImpulse()
            firstTouch = false
        } else {
            let touch = touches.anyObject() as UITouch
            let touchLocation = touch.locationInNode(self) as CGPoint
            moveToPosition(touchLocation)
        }
    }
    
    //Function for moving from one position to a touch position. Scale to speed movement.
    func moveToPosition(position: CGPoint) {
        /*let speed = 0.1 as CGFloat
        var dx = position.x - player.position.x
        var dy = player.position.y
        dx = dx * speed
        dy = dy * speed*/
        
        //new position of player updated here
        player.position = CGPointMake(position.x, player.position.y)
    }
    
    func adjustFacingDirection(location: CGPoint) {
        if (player.facingRight && player.position.x > location.x) |
            (!player.facingRight && player.position.x < location.x) {
            player.flipFace()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //TORUS
    }
    
    
}
