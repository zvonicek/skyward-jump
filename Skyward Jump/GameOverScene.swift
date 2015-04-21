//
//  GameOverScene.swift
//  Skyward Jump
//
//  Created by Kieu Nguyen on 09/04/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    //Parent view controller delegate
    weak var controllerDelegate: GameViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding has not been implemented")
    }
    
    init(size: CGSize, score: String, opponentScore: String?, gameover: Bool) {
        super.init(size: size)
        
        //set background color to scene
        self.backgroundColor = UIColor(red: 196/255.0, green: 223/255.0, blue: 155/255.0, alpha: 1.0)
        
        //add game over label
        /*change to a cooler game over picture picture*/
        var gameOverLabel = SKLabelNode(fontNamed: "FFFForward")
        gameOverLabel.fontSize = 35
        gameOverLabel.fontColor = SKColor.whiteColor()
        gameOverLabel.position = CGPoint(x:self.size.width/2, y: 425)
        self.addChild(gameOverLabel)
        
        //add player score label
        /*needs to retrieve and update the score of the player*/
        var playerScoreLabel = SKLabelNode(fontNamed: "FFFForward")
        playerScoreLabel.fontSize = 20
        playerScoreLabel.fontColor = SKColor.whiteColor()
        playerScoreLabel.position = CGPoint(x: self.size.width / 2, y: 350)
        playerScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        playerScoreLabel.text = "Your score: \(score)"
        addChild(playerScoreLabel)
        
        if opponentScore == nil {
            if gameover {
                gameOverLabel.text = "Game Over"
            } else {
                gameOverLabel.text = "You reached the top"
                gameOverLabel.fontSize = 20
            }
            
            initSinglePlayer(score)
        } else {
            if opponentScore!.toInt()! > score.toInt()! {
                gameOverLabel.text = "You lose!"
            } else {
                gameOverLabel.text = "You win!"
            }
            
            initMultiPlayer(opponentScore!)
        }
        
        var exitButton = TWButton(normalColor: UIColor.blackColor(), highlightedColor: UIColor.whiteColor(), size: CGSizeMake(180, 40))
        exitButton.allStatesLabelFontName = "FFFForward"
        exitButton.allStatesLabelFontSize = 15
        exitButton.allStatesLabelText = "Quit game"
        exitButton.position = CGPoint(x: self.size.width/2, y: 100)
        exitButton.addClosureFor(UIControlEvents.TouchUpInside, target: self) { (target, sender) -> () in
            target.quitGame()
        }
        
        addChild(exitButton)
    }
    
    func initSinglePlayer(score: String) {
        var playAgainButton = TWButton(normalColor: UIColor.blackColor(), highlightedColor: UIColor.whiteColor(), size: CGSizeMake(180, 40))
        playAgainButton.allStatesLabelFontName = "FFFForward"
        playAgainButton.allStatesLabelFontSize = 15
        playAgainButton.allStatesLabelText = "Play again"
        playAgainButton.position = CGPoint(x: self.size.width/2, y: 150)
        playAgainButton.addClosureFor(UIControlEvents.TouchUpInside, target: self) { (target, sender) -> () in
            target.controllerDelegate!.playGame()
        }
        addChild(playAgainButton)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var highScore: String
        
        if var hs = userDefaults.stringForKey("highScore") where hs.toInt()! > score.toInt()!
        {
            highScore = hs
        } else {
            highScore = score
            userDefaults.setObject(score, forKey: "highScore")
        }
        
        var highScoreLabel = SKLabelNode(fontNamed: "FFFForward")
        highScoreLabel.fontSize = 20
        highScoreLabel.fontColor = SKColor.whiteColor()
        highScoreLabel.position = CGPoint(x: self.size.width / 2, y: 300)
        highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        highScoreLabel.text = "High score: \(highScore)"
        addChild(highScoreLabel)
    }
    
    func initMultiPlayer(opponentScore: String) {
        var opponentScoreLabel = SKLabelNode(fontNamed: "FFFForward")
        opponentScoreLabel.fontSize = 20
        opponentScoreLabel.fontColor = SKColor.whiteColor()
        opponentScoreLabel.position = CGPoint(x: self.size.width / 2, y: 300)
        opponentScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        opponentScoreLabel.text = "Opponent score: \(opponentScore)"
        addChild(opponentScoreLabel)
    }
    
    func quitGame(){
        controllerDelegate?.dismissViewController()
    }
}
