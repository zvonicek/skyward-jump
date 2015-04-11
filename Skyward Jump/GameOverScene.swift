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
            
            //add player score label
            /*needs to retrieve and update the score of the player*/
            var playerScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
            playerScoreLabel.fontSize = 20
            playerScoreLabel.fontColor = SKColor.blackColor()
            playerScoreLabel.position = CGPoint(x: self.size.width / 2, y: 300)
            playerScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            playerScoreLabel.text = "Score \(score)"
            addChild(playerScoreLabel)
            
            if (opponentScore != nil) {
                var opponentScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
                opponentScoreLabel.fontSize = 20
                opponentScoreLabel.fontColor = SKColor.blackColor()
                opponentScoreLabel.position = CGPoint(x: self.size.width / 2, y: 250)
                opponentScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
                opponentScoreLabel.text = "Opponent score \(opponentScore!)"
                addChild(opponentScoreLabel)
            }
        }
        
        //call to check which mode we are in.
        createPlayerModeLabel()
        
        if opponentScore == nil {
            var playAgainButton = TWButton(normalColor: UIColor.brownColor(), highlightedColor: UIColor.blackColor(), size: CGSizeMake(180, 40))
            playAgainButton.allStatesLabelFontName = "HelveticaNeue"
            playAgainButton.allStatesLabelFontSize = 19
            playAgainButton.allStatesLabelText = "Play again"
            playAgainButton.position = CGPoint(x: self.size.width/2, y: 150)
            playAgainButton.addClosureFor(UIControlEvents.TouchUpInside, target: self) { (target, sender) -> () in
                target.controllerDelegate!.playGame()
            }
            
            addChild(playAgainButton)            
        }
        
        var exitButton = TWButton(normalColor: UIColor.brownColor(), highlightedColor: UIColor.blackColor(), size: CGSizeMake(180, 40))
        exitButton.allStatesLabelFontName = "HelveticaNeue"
        exitButton.allStatesLabelFontSize = 19
        exitButton.allStatesLabelText = "Quit game"
        exitButton.position = CGPoint(x: self.size.width/2, y: 100)
        exitButton.addClosureFor(UIControlEvents.TouchUpInside, target: self) { (target, sender) -> () in
            target.quitGame()
        }
        
        
        addChild(exitButton)
        
        
    }
    
    func quitGame(){
        controllerDelegate?.dismissViewController()
    }

        

}
