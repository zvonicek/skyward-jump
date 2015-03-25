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
    
    let platformLayer: PlatformLayerNode
    
    //Pause-button
    let pauseButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    let pauseIcon = UIImage(named: "pause.png")
    let playIcon = UIImage(named: "play.png")
    
    //Controll attributes
    var firstTouch = true
    
    //Sound effects
    let bounceSound = SKAction.playSoundFileNamed("bounce.mp3", waitForCompletion: false);
    
    //Start location of the player
    var location = CGPointMake(50, 50)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding has not been implemented")
    }
    
    override init(size: CGSize) {
        let platform1 = Platform(position: CGPointMake(200, 100))
        let platform2 = Platform(position: CGPointMake(50, 200))
        let world = World(platforms: [platform1, platform2])
        
        platformLayer = PlatformLayerNode(world: world)
        
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        
        //Adds gravity to the y-direction
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        //Add contact delegate
        physicsWorld.contactDelegate = self
        
        player.createPlayer()
        
        //Add and configure pause-button
        pauseButton.frame = CGRectMake(self.size.width * 0.9, 10, 30, 30)
        pauseButton.setImage(pauseIcon, forState: .Normal)
        pauseButton.addTarget(self, action: "pauseGame:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func didMoveToView(view: SKView) {
        self.addChild(platformLayer)
        self.addChild(player)
        self.view?.addSubview(pauseButton)
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
            adjustFacingDirection(touchLocation)
            moveToPosition(touchLocation)
        }
    }
    
    //Function for moving from one position to a touch position. Scale to speed movement.
    func moveToPosition(position: CGPoint) {
        //new position of player updated here
        let newPosition = CGPointMake(position.x, player.position.y)
        let dx = abs(position.x - player.position.x)/1000
        let time = NSTimeInterval(dx + 0.8)
        player.runAction(SKAction.moveToX(position.x, duration: time))
    }
    
    func adjustFacingDirection(location: CGPoint) {
        if (player.facingRight && player.position.x > location.x) |
            (!player.facingRight && player.position.x < location.x) {
            player.flipFace()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        let pWidth = player.sprite.size.width
        if player.position.x > self.size.width + pWidth {
            player.position = CGPoint(x: -pWidth, y: player.position.y)
        } else if player.position.x < -pWidth {
            player.position = CGPoint(x: self.size.width + pWidth, y: player.position.y)
        }
    }
    
    func pauseGame(sender: UIButton){
        self.paused = !self.paused
        let pauseImg = self.paused ? playIcon : pauseIcon
        pauseButton.setImage(pauseImg, forState: .Normal)
    }
    
}
