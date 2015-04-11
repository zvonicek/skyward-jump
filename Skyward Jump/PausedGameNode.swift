//
//  PausedGameNode.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 06.04.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import SpriteKit

class PausedGameNode: SKSpriteNode {
    
    var labelNode = SKLabelNode(fontNamed: "HelveticaNeue-Light")
    var resumeButton = TWButton(normalColor: UIColor.brownColor(), highlightedColor: UIColor.blackColor(), size: CGSizeMake(180, 40))
    var quitButton = TWButton(normalColor: UIColor.brownColor(), highlightedColor: UIColor.blackColor(), size: CGSizeMake(180, 40))
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor(white: 0, alpha: 0.5), size: size)
        self.position = CGPointMake(size.width / 2, size.height / 2)
        
        //Configure LabelNode
        labelNode.position = CGPointMake(0, 100)
        labelNode.text = "PAUSE"

        resumeButton.allStatesLabelText = "Resume"
        resumeButton.allStatesLabelFontName = "HelveticaNeue"
        resumeButton.allStatesLabelFontSize = 19
        resumeButton.position = CGPointMake(0, 0)
        
        //Configure QuitButton
        quitButton.allStatesLabelText = "Quit"
        quitButton.allStatesLabelFontName = "HelveticaNeue"
        quitButton.allStatesLabelFontSize = 19
        quitButton.position = CGPointMake(0, -50)
        
        self.addChild(labelNode)
        self.addChild(resumeButton)
        self.addChild(quitButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
