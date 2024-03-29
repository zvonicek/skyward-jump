//
//  GameViewController.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import UIKit
import SpriteKit

protocol GameViewControllerDelegate: class {
    func dismissViewController()
    func showScoreboard(score: String, opponentScore: String?, gameover: Bool)
    func playGame()
}

class GameViewController: UIViewController, GameViewControllerDelegate {
    
    var multiplayerMode = false
    var scene: SKScene?
    var negotiatedWorld: World?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playGame()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: GameViewControllerDelegate
    func dismissViewController() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func showScoreboard(score: String, opponentScore: String?, gameover: Bool) {
        let skView = view as! SKView
        
        if let scene = scene {
            scene.removeFromParent()
        }
        
        scene = GameOverScene(size: scene!.size, score: score, opponentScore: opponentScore, gameover: gameover)
        (scene as! GameOverScene).controllerDelegate = self
        skView.presentScene(scene)
    }
    
    func playGame() {
        let skView = view as! SKView
        
        if let scene = scene {
            scene.removeFromParent()
        }

        let height = UIScreen.mainScreen().bounds.height == 480 ? 480 : 568
        let size = CGSizeMake(320, CGFloat(height))
        scene = multiplayerMode ? MultiplayerGameScene(size:size, initWorld: negotiatedWorld) : GameScene(size: size, initWorld: negotiatedWorld)
        (scene as! GameScene).controllerDelegate = self
        scene!.scaleMode = .AspectFill
        skView.presentScene(scene!)        
    }
}
