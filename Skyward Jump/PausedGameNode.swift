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
    var quitButton = TWButton(normalColor: UIColor.brownColor(), highlightedColor: UIColor.blackColor(), size: CGSizeMake(180, 40))
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor(white: 0, alpha: 0.5), size: size)
        self.position = CGPointMake(size.width / 2, size.height / 2)
        
        //Configure LabelNode
        labelNode.position = CGPointMake(0, +100)
        labelNode.text = "PAUSE"
        
        //Configure QuitButton
        quitButton.stateNormalLabel.fontName = "HelveticaNeue"
        quitButton.stateNormalLabel.fontSize = 19
        quitButton.stateNormalLabelText = "Quit"
        quitButton.position = CGPointMake(0, 0)
        
        self.addChild(labelNode)
        self.addChild(quitButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
