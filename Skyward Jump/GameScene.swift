//
//  GameScene.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//


//// layerPlatform will contain player sprite
// test


import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Parent view controller delegate
    weak var controllerDelegate: GameViewControllerDelegate?
    
    //Sprites to add to the scene
    let player: CharacterSprite = CharacterSprite() //create a player node
    
    let platformLayer: PlatformLayer
    
    //Pause-button
    let pauseButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    let pauseIcon = UIImage(named: "pause.png")
    let playIcon = UIImage(named: "play.png")
    
    //Pause-node
    let pauseNode: PausedGameNode

    //Score-label
    let scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
    
    //Controll attributes
    var firstTouch = true
    var score = 0
    var highestPoint: CGFloat
    let playerStartHeight: CGFloat = 100
    
    //Sound effects
    let bounceSound = SKAction.playSoundFileNamed("bounce.mp3", waitForCompletion: false);
    
    //Start location of the player
    var location = CGPointMake(50, 50)
    
    ///// PING //////
    var maxY: Int
    let distanceFromPlayer: CGFloat = 200
    let endLevelY:Int?
    
    // Motion manager for accelerometer
    let motionManager: CMMotionManager = CMMotionManager()
    
    // Acceleration value from accelerometer
    var xAcceleration: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding has not been implemented")
    }
    
    override init(size: CGSize) {
        var w = WorldFactory(level: 1)
        self.endLevelY = w.levelHeight
        var platforms = w.fixedPath
        platforms += w.extraPath
        platforms += w.voidPath
        println(w.extraPath.count)
        println(w.voidPath.count)
        println(platforms.count)
        
        let world = World(platforms: platforms)
        platformLayer = PlatformLayer(world: world)
        platformLayer.addChild(player)
        
        highestPoint = playerStartHeight
        pauseNode = PausedGameNode(size: size)
        
        //// PING ////
        maxY = Int(playerStartHeight)
        
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        
        //Adds gravity to the y-direction
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        //Add contact delegate
        physicsWorld.contactDelegate = self
        player.createPlayer(playerStartHeight)
        
        //Configure pause-button
        pauseButton.frame = CGRectMake(self.size.width * 0.9, 10, 30, 30)
        pauseButton.setImage(pauseIcon, forState: .Normal)
        pauseButton.addTarget(self, action: "pauseGame:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Configure pause-node
        pauseNode.quitButton.addClosureFor(UIControlEvents.TouchUpInside, target: self) { (target, sender) -> () in
            target.quitGame()
        }
                
        //Configure score-label
        scoreLabel.fontSize = 14
        scoreLabel.position = CGPoint(x: self.size.width * 0.8, y: self.size.height - 30)
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.text = "Score: 0"
        
        // CoreMotion
        // get value every 0.2sec
        motionManager.accelerometerUpdateInterval = 0.2
        // every 0.2sec, execute the block of code
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
            (accelerometerData: CMAccelerometerData!, error: NSError!) in
            
            let acceleration = accelerometerData.acceleration
            self.xAcceleration = (CGFloat(acceleration.x) * 0.75) + (self.xAcceleration * 0.25)
        })
    }
    
    deinit {
        self.pauseButton.removeFromSuperview()
    }
    
    override func didSimulatePhysics() {
        // set velocity based on x-axis acceleration
        player.physicsBody?.velocity = CGVector(dx: xAcceleration * 400.0, dy: player.physicsBody!.velocity.dy)
        
        // check x bounds
        if player.position.x < -20.0 {
            player.position = CGPoint(x: self.size.width + 20.0, y: player.position.y)
        } else if player.position.x > self.size.width + 20.0 {
            player.position = CGPoint(x: -20.0, y: player.position.y)
        }
    }
    
    override func didMoveToView(view: SKView) {
        self.addChild(platformLayer)
        self.view?.addSubview(pauseButton)
        self.addChild(scoreLabel)
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
//            runAction(bounceSound)
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 300.0)
        }
        
        //TODO:
        //if: check if collision with floor, move over to GameOver Scene
        //if: check if collision with wall, move through wall to other side
        
    }
    
    
    //Touch anywhere on the screen, and the game starts. Setting dynamics to true and adds initial upwards impulse
    //to the player.
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if firstTouch {
            player.startPlayerDynamics()
            player.startPlayerImpulse()
            firstTouch = false
        } else {
            let touch = touches.first as! UITouch
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
        if (player.facingRight && player.position.x > location.x) ||
            (!player.facingRight && player.position.x < location.x) {
            player.flipFace()
        }
    }
    
    func getScoreString() -> String {
        let str = "\(highestPoint)"
        return str.substringToIndex(str.endIndex.predecessor().predecessor())
    }
    
    func updateScore(){
        if player.position.y > highestPoint {
            highestPoint = floor(player.position.y)
            scoreLabel.text = "Score: \(getScoreString())"
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        let pWidth = player.sprite.size.width
        if player.position.x > self.size.width + pWidth {
            player.position = CGPoint(x: -pWidth, y: player.position.y)
        } else if player.position.x < -pWidth {
            player.position = CGPoint(x: self.size.width + pWidth, y: player.position.y)
        }
        updateScore()
        
        // remove game objects that have passed by
        platformLayer.enumerateChildNodesWithName("PLATFORM_NODE", usingBlock: {
            (node, stop) in
            let p = node as! CloudSprite
            if self.player.position.y > p.position.y + self.distanceFromPlayer {
                p.removeFromParent()
            }
        })
        
        // move scene
        if player.physicsBody?.velocity.dy > 0 && Int(player.position.y) > maxY {
            platformLayer.position = CGPoint(x: 0.0, y: -(player.position.y - 200.0))
            
        }
        
        // Check if we've finished the level
        if Int(player.position.y) > self.endLevelY {
            /// implement finsih level 1
        }
        
        if Int(player.position.y) > maxY {
            maxY = Int(player.position.y)
        }
        // Call the game over scene when falling to far downwards
        if Int(player.position.y) < maxY - 200 {
            
            //game scene called
            controllerDelegate!.showScoreboard(getScoreString(), opponentScore: nil)

            println("die")
        }

    }
    
    func pauseGame(sender: UIButton){
        self.paused = !self.paused
        
        if paused {
            self.addChild(pauseNode)
        } else {
            pauseNode.removeFromParent()
        }
        let pauseImg = self.paused ? playIcon : pauseIcon
        pauseButton.setImage(pauseImg, forState: .Normal)
    }
    
    func quitGame(){
        controllerDelegate?.dismissViewController()
    }
}
