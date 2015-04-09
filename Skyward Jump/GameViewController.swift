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
}

class GameViewController: UIViewController, GameViewControllerDelegate {
    var multiplayerMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let height = UIScreen.mainScreen().bounds.height == 480 ? 480 : 568
        let size = CGSizeMake(320, CGFloat(height))
        let scene = multiplayerMode ? MultiplayerGameScene(size:size) : GameScene(size: size)
        scene.controllerDelegate = self
        let skView = view as! SKView
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: GameViewControllerDelegate
    func dismissViewController() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}
