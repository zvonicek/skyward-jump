//
//  GameOverScene.swift
//  Skyward Jump
//
//  Created by Kieu Nguyen on 09/04/15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

class GameOverScene: SKScene {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding has not been implemented")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        //add player score label
        let scoreLabel = SKLabelNode(fontNamed: "HelveticaNeue-Light")
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: 300)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        //Fix
//        scoreLabel.text =
        addChild(scoreLabel)


    }
    


}