//
//  MenuVC.swift
//  DoublePong
//
//  Created by Ameer Khan on 7/18/17.
//  Copyright © 2017 Ameer Khan. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case veryeasy
    case easy
    case medium
    case hard
    case veryhard
    case player2
}

class MenuVC: UIViewController {
    
    @IBAction func VeryEasy(_ sender: Any) {
        moveToGame(game: .veryeasy)
    }
    
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    @IBAction func VeryHard(_ sender: Any) {
        moveToGame(game: .veryhard)
    }
    
    @IBAction func Player2(_ sender: Any) {
        moveToGame(game: .player2)
    }
    
    func moveToGame(game: gameType){
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
