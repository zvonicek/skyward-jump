//
//  MultiplayerGameScene.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 18.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import Foundation
import SpriteKit

class MultiplayerGameScene: GameScene, CommunicationDelegate {
    
    let opponent = OpponentSprite()
    var opponentScore = 0
    let arrow = SKSpriteNode(imageNamed: "arrow")
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        platformLayer.addChild(opponent)
        
        arrow.size = CGSizeMake(30, 30)
        self.addChild(arrow)
        
        MultiplayerManager.sharedInstance.comm.delegate = self
    }
    
    deinit {
        MultiplayerManager.sharedInstance.comm.delegate = nil
    }
    
    override func update(currentTime: CFTimeInterval) {
        super.update(currentTime)
        MultiplayerManager.sharedInstance.comm.sendMove(player.position, facingRight: player.facingRight, score: getScoreString().toInt()!)
    }
    
    override func characterDidDie(gameover: Bool) {
        MultiplayerManager.sharedInstance.comm.sendMatchEnded(getScoreString().toInt()!, interrupted: false)
        
        controllerDelegate!.showScoreboard(getScoreString(), opponentScore: "\(opponentScore)", gameover: true)
    }
    
    override func quitGame() {
        MultiplayerManager.sharedInstance.comm.sendMatchEnded(getScoreString().toInt()!, interrupted: true)
        super.quitGame()
    }
    
    // MARK: CommunicationDelegate
    func updateOpponentMove(point: CGPoint, facingRight: Bool, score: Int) {
        opponent.position = point
        opponent.facingRight = facingRight
        opponentScore = score
        
        let padding = 20
        
        if -platformLayer.position.y > point.y + opponent.size.height {
            arrow.position = CGPointMake(point.x, CGFloat(padding))
            arrow.hidden = false
            arrow.yScale = -1.0
        } else if -platformLayer.position.y + self.size.height < point.y {
            arrow.position = CGPointMake(point.x, self.size.height - CGFloat(padding))
            arrow.hidden = false
            arrow.yScale = 1.0
        } else {
            arrow.hidden = true
        }
    }
    
    func lostConnection() {
        let alert = UIAlertView(title: "Error", message: "Connection with other player was lost", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
        println("lost connection")
        controllerDelegate?.dismissViewController()
    }
    
    func gameOver(score: Int, interrupted: Bool) {
        controllerDelegate?.showScoreboard(getScoreString(), opponentScore: "\(score)", gameover: true)
    }
}