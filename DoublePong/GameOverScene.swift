//
//  GameOverScene.swift
//  DoublePong
//
//  Created by Ameer Khan on 7/20/17.
//  Copyright © 2017 Ameer Khan. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won:Bool) {
        
        super.init(size: size)
        
        // these lines of code is used to play music in the background
        let music = SKAudioNode(fileNamed: "Electro Sketch.mp3")
        addChild(music)
        music.isPositional = true
        music.position = CGPoint(x: -1024, y: 0)
        let moveForward = SKAction.moveTo(x: 1024, duration: 2)
        let moveBack = SKAction.moveTo(x: -1024, duration: 2)
        let sequence = SKAction.sequence([moveForward, moveBack])
        let repeatForever = SKAction.repeatForever(sequence)
        music.run(repeatForever)
        
        backgroundColor = SKColor.black // changes the color of the background
        
        let message = won ? "You Won! :]" : "You Lose :[" // content of the message
        
        // displays the message
        let label = SKLabelNode(fontNamed: "chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.white
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        // reveals the message as desired
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
        let scene = GameScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
