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
    
    init(size: CGSize, score: String, opponentScore: String?) {
        super.init(size: size)
        
        //set background color to scene
        self.backgroundColor = SKColor.whiteColor()
        
        
        //add game over label
        /*change to a cooler game over picture picture*/
        var gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.fontSize = 40
        gameOverLabel.fontColor = SKColor.blackColor()
        gameOverLabel.position = CGPoint(x:self.size.width/2, y: 350)
        gameOverLabel.text = "Game Over"
        self.addChild(gameOverLabel)
        
        func createPlayerModeLabel() {
            
            if(opponentScore == nil) {
                
                //add player score label
                /*needs to retrieve and update the score of the player*/
                var playerScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
                playerScoreLabel.fontSize = 20
                playerScoreLabel.fontColor = SKColor.blackColor()
                playerScoreLabel.position = CGPoint(x: self.size.width / 2, y: 300)
                playerScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
                playerScoreLabel.text = score
                addChild(playerScoreLabel)
                
            } else {
                
                //add player score label
                /*needs to retrieve and update the score of the player*/
                var playerScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
                playerScoreLabel.fontSize = 20
                playerScoreLabel.fontColor = SKColor.blackColor()
                playerScoreLabel.position = CGPoint(x: self.size.width / 2, y: 300)
                playerScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
                playerScoreLabel.text = score
                addChild(playerScoreLabel)
                
                
                var opponentScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
                opponentScoreLabel.fontSize = 20
                opponentScoreLabel.fontColor = SKColor.blackColor()
                opponentScoreLabel.position = CGPoint(x: self.size.width / 2, y: 250)
                opponentScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
                opponentScoreLabel.text = opponentScore!
                addChild(opponentScoreLabel)
                
            }
        }
        
        //call to check which mode we are in.
        createPlayerModeLabel()
        
        
        var playAgainButton = TWButton(normalColor: UIColor.brownColor(), highlightedColor: UIColor.blackColor(), size: CGSizeMake(180, 40))
        playAgainButton.stateNormalLabel.fontName = "HelveticaNeue"
        playAgainButton.stateNormalLabel.fontSize = 19
        playAgainButton.stateNormalLabelText = "Play again"
        playAgainButton.position = CGPoint(x: self.size.width/2, y: 150)
        playAgainButton.addClosureFor(UIControlEvents.TouchUpInside, target: self) { (target, sender) -> () in
            target.controllerDelegate!.playGame()
        }
        
        addChild(playAgainButton)
        
        
    }
}
