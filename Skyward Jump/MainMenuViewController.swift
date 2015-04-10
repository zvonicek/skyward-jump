//
//  MainMenuViewController.swift
//  Skyward Jump
//
//  Created by Petr Zvoníček on 16.03.15.
//  Copyright (c) 2015 NTNU. All rights reserved.
//

import UIKit
import GameKit

class MainMenuViewController: UIViewController {

    @IBOutlet var singlePlayerButton: UIButton!
    @IBOutlet var multiPlayerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MultiplayerManager.sharedInstance.comm.authenticate(self)
    }

    @IBAction func didClickMultiplayerButton(sender: UIButton) {
        MultiplayerManager.sharedInstance.comm.findMatch(self, callback: { (world) -> Void in
            self.performSegueWithIdentifier("multiplayerSegue", sender: self)
        })        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let dest = segue.destinationViewController as? GameViewController {
            if segue.identifier == "multiplayerSegue" {
                dest.multiplayerMode = true
            }
        }
    }
}
