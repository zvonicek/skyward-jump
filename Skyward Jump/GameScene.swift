//
//  GameScene.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//


//// layerPlatform will contain player sprite

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
    
    //Background-node
    let backgroundNode: SKSpriteNode
    var backgroundNodePrevPosition: CGFloat = 0

    //Score-label
    let scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
    
    //Controll attributes
    var firstTouch = true
    var score = 0
    var highestPoint: CGFloat
    let playerStartHeight: CGFloat = 60
    
    //Sound effects
    //let bounceSound = SKAction.playSoundFileNamed("bounce.mp3", waitForCompletion: false);
    
    //Start location of the player
    var location = CGPointMake(50, 50)
    
    ///// PING //////
    var maxY: Int
    let distanceFromPlayer: CGFloat = 300
    let endLevelY:Int?
    
    // Motion manager for accelerometer
    let motionManager: CMMotionManager = CMMotionManager()
    
    // Acceleration value from accelerometer
    var xAcceleration: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding has not been implemented")
    }
    
    override convenience init(size: CGSize) {
        self.init(size: size, initWorld: nil)
    }
    
    init(size: CGSize, initWorld: World?) {
        var w = WorldFactory()
        self.endLevelY = w.levelHeight
        
        let world: World
        
        if let w = initWorld {
            world = w
        } else {
            var platforms = w.fixedPath
            platforms += w.extraPath
            platforms += w.voidPath
            
            world = World(platforms: platforms)
        }

        platformLayer = PlatformLayer(world: world)
        
        for cSprite in w.coins {
            platformLayer.addChild(cSprite)
        }
        platformLayer.addChild(player)
        
        highestPoint = playerStartHeight
        pauseNode = PausedGameNode(size: size)
        
        backgroundNode = SKSpriteNode()
        backgroundNode.size = CGSizeMake(size.width * 2, size.height * 2)
        backgroundNode.color = UIColor(red: 196/255.0, green: 223/255.0, blue: 155/255.0, alpha: 1.0)
        
        //// PING ////
        maxY = Int(playerStartHeight)
        
        super.init(size: size)
        
        //Adds gravity to the y-direction
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        
        //Add contact delegate
        physicsWorld.contactDelegate = self
        player.createPlayer(playerStartHeight)
        
        //Configure pause-button
        pauseButton.frame = CGRectMake(self.size.width * 0.9, 10, 30, 30)
        pauseButton.setImage(pauseIcon, forState: .Normal)
        pauseButton.addTarget(self, action: "pauseGame", forControlEvents: UIControlEvents.TouchUpInside)
        
        //Configure pause-node
        pauseNode.quitButton.addClosureFor(UIControlEvents.TouchUpInside, target: self) { (target, sender) -> () in
            target.quitGame()
        }
        pauseNode.resumeButton.addClosureFor(UIControlEvents.TouchUpInside, target: self) { (target, sender) -> () in
            target.pauseGame()
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
        self.adjustFacingDirection()

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
        self.addChild(backgroundNode)
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
            //runAction(bounceSound)
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 300.0)
        }
        
        if (firstBody.categoryBitMask == Category.Player && secondBody.categoryBitMask == Category.Coin) {
            secondBody.node?.removeFromParent()
            updateScore()
        
        }
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if firstTouch {
            player.startPlayerDynamics()
            player.startPlayerImpulse()
            firstTouch = false
        } else {
            let touch = touches.first as! UITouch
            let touchLocation = touch.locationInNode(self) as CGPoint
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
    
    func adjustFacingDirection() {
        if (player.facingRight && self.xAcceleration < 0) ||
            (!player.facingRight && self.xAcceleration > 0) {
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
        if Int(player.position.y) > maxY && player.position.y > 200.0 {
            platformLayer.position = CGPoint(x: 0.0, y: -(player.position.y - 200.0))
            updateBackgroundColorIfNeeded()
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
            self.characterDidDie()
        }
    }
    
    func updateBackgroundColorIfNeeded() {
        let levelHeight = 7300
        var colors = [UIColor(red: 119/255.0, green: 196/255.0, blue: 209/255.0, alpha: 1.0),
        UIColor(red: 138/255.0, green: 131/255.0, blue: 205/255.0, alpha: 1.0),
        UIColor(red: 28/255.0, green: 132/255.0, blue: 147/255.0, alpha: 1.0)]
        var newColor: UIColor?
        let threshold = levelHeight / (colors.count + 1)
        
        for var i = colors.count; i > 0; i-- {
            if -self.platformLayer.position.y > CGFloat(i*threshold) && backgroundNodePrevPosition < CGFloat(i*threshold) {
                print("set")
                self.backgroundNodePrevPosition = -self.platformLayer.position.y
                let action = SKAction.colorizeWithColor(colors[i-1], colorBlendFactor: 0.0, duration: 5.0)
                self.backgroundNode.runAction(action)
                break
            }
        }
    }
    
    func characterDidDie() {
        controllerDelegate!.showScoreboard(getScoreString(), opponentScore: nil)
    }
    
    func pauseGame(){
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
