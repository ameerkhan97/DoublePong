//
//  GameViewController.swift
//  DoublePong
//
//  Created by Ameer Khan on 7/12/17.
//  Copyright © 2017 Ameer Khan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

enum gameState {
    case play
    case pause
    case restart
    case mainmenu
}

var currentGameType = gameType.medium
var currentGameState = gameState.play

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                scene.size = view.bounds.size
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func Play(_ sender: Any) {
        moveToState(state: .play)
    }
    
    @IBAction func Pause(_ sender: Any) {
        moveToState(state: .pause)
    }
    
    @IBAction func Restart(_ sender: Any) {
        moveToState(state: .restart)
        self.viewDidLoad()
    }
    
    @IBAction func MainMenu(_ sender: Any) {
        moveToState(state: .mainmenu)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func moveToState(state: gameState){
        currentGameState = state
    }
}
