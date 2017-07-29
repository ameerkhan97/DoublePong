//
//  GameScene.swift
//  DoublePong
//
//  Created by Ameer Khan on 7/12/17.
//  Copyright © 2017 Ameer Khan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball1 = SKSpriteNode()
    var ball2 = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var pscore1 = SKLabelNode()
    var oppscore2 = SKLabelNode()
    
    var pscore2 = SKLabelNode()
    var oppscore1 = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        // these lines of code are used to play music in the background
        let music = SKAudioNode(fileNamed: "Electro Sketch.mp3")
        addChild(music)
        music.isPositional = true
        music.position = CGPoint(x: -1024, y: 0)
        let moveForward = SKAction.moveTo(x: 1024, duration: 2)
        let moveBack = SKAction.moveTo(x: -1024, duration: 2)
        let sequence = SKAction.sequence([moveForward, moveBack])
        let repeatForever = SKAction.repeatForever(sequence)
        music.run(repeatForever)
        
        pscore1 = self.childNode(withName: "pscore1") as! SKLabelNode
        oppscore2 = self.childNode(withName: "oppscore2") as! SKLabelNode
        
        pscore2 = self.childNode(withName: "pscore2") as! SKLabelNode
        oppscore1 = self.childNode(withName: "oppscore1") as! SKLabelNode

        ball1 = self.childNode(withName: "ball1") as! SKSpriteNode
        ball2 = self.childNode(withName: "ball2") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
    }
    
    // function to start the game
    func startGame() {
        score = [0,0]
        
        pscore1.text = "\(score[0])"
        oppscore2.text = "\(score[0])"
        
        pscore2.text = "\(score[1])"
        oppscore1.text = "\(score[1])"
        
        ball1.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        ball2.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))

    }
    
    // function to add score of the first ball
    func addScore1(playerWhoWon: SKSpriteNode) {
        ball1.position = CGPoint(x: 0, y: 0)
        ball1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball1.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball1.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }

        pscore1.text = "\(score[0])"
        oppscore2.text = "\(score[0])"
        
        pscore2.text = "\(score[1])"
        oppscore1.text = "\(score[1])"
        
        gameOver()
        
    }
    
    // function to add score of the second ball
    func addScore2(playerWhoWon: SKSpriteNode) {
        ball2.position = CGPoint(x: 0, y: 0)
        ball2.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball2.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball2.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        
        pscore1.text = "\(score[0])"
        oppscore2.text = "\(score[0])"
        
        pscore2.text = "\(score[1])"
        oppscore1.text = "\(score[1])"
        
        gameOver()
    }
    
    
    // function to resume the game when paused
    func playGame(){
        scene?.view?.isPaused = false
    }
    
    //function to pause the game
    func pauseGame(){
        scene?.view?.isPaused = true
    }
    
    // function that when score of 10 is reached, gameover scene is presented
    func gameOver(){
        if score[0] == 10 {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        else if score[1] == 10 {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            if currentGameState == .play {
                playGame()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            if currentGameState == .play {
                playGame()
            }
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        // determines difficulty of each game type
        switch currentGameType{
        
        case .veryeasy:
            if ball1.position.y >= ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball1.position.x, duration: 1.3))
            }
            else if ball1.position.y < ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball2.position.x, duration: 1.3))
            }
            break
            
        case .easy:
            if ball1.position.y >= ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball1.position.x, duration: 1.1))
            }
            else if ball1.position.y < ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball2.position.x, duration: 1.1))
            }
            break
            
        case .medium:
            if ball1.position.y >= ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball1.position.x, duration: 0.9))
            }
            else if ball1.position.y < ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball2.position.x, duration: 0.9))
            }
            break
            
        case .hard:
            if ball1.position.y >= ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball1.position.x, duration: 0.7))
            }
            else if ball1.position.y < ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball2.position.x, duration: 0.7))
            }
            break
            
        case .veryhard:
            if ball1.position.y >= ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball1.position.x, duration: 0.5))
            }
            else if ball1.position.y < ball2.position.y {
                enemy.run(SKAction.moveTo(x: ball2.position.x, duration: 0.5))
            }
            break
            
        case .player2:
            
            break
        }
        
        // runs the follwing game state functions play, pause and restart
        switch currentGameState{
            
        case .play:
            playGame()
            break
            
        case .pause:
            pauseGame()
            break
        
        case .restart:
            
            break
            
        case .mainmenu:
            
            break
        }
        
        // once ball1 is past a certain position, the score is added
        if ball1.position.y <= main.position.y - 30 {
            addScore1(playerWhoWon: enemy)
        }
        else if ball1.position.y >= enemy.position.y + 30 {
            addScore1(playerWhoWon: main)
        }
        
        // once ball2 is past a certain position, the score is added
        if ball2.position.y <= main.position.y - 30 {
            addScore2(playerWhoWon: enemy)
        }
        else if ball2.position.y >= enemy.position.y + 30 {
            addScore2(playerWhoWon: main)
        }
    }
}
