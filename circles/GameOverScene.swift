//
//  GameOverScene.swift
//  circles
//
//  Created by Gareth Carless on 11/04/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    var level = 0
    var hasWon = false
    var viewController: GameViewController!
    
    func assignViewController(controller: GameViewController) {
        viewController = controller
    }
    
    override func didMoveToView(view: SKView) {
        print("(\(self.view!.frame.midX + 75),\(self.size.height/2 - 30)")
        self.scaleMode = .ResizeFill
        self.backgroundColor = UIColor.whiteColor()
        let quitNode = SKLabelNode.init(text: "Quit")
        quitNode.position = CGPoint(x: self.view!.frame.midX + 75, y: self.view!.frame.midY - 30)
        quitNode.fontColor = UIColor.blackColor()
        quitNode.name = "quit"
        self.addChild(quitNode)
        
        if(hasWon) {
            let gameOverWinNode = SKLabelNode.init(text: "You Win!")
            gameOverWinNode.position = CGPoint(x: self.view!.frame.midX, y: self.view!.frame.midY + 20)
            gameOverWinNode.fontColor = UIColor.blackColor()
            self.addChild(gameOverWinNode)
            
            let nextNode = SKLabelNode.init(text: "Next Level")
            nextNode.position = CGPoint(x: self.view!.frame.midX - 75, y: self.view!.frame.midY - 30)
            nextNode.fontColor = UIColor.blackColor()
            nextNode.name = "next"
            self.addChild(nextNode)
        }
        else {
            let gameOverLoseNode = SKLabelNode.init(text: "You Lose!")
            gameOverLoseNode.position = CGPoint(x: self.view!.frame.midX, y: self.view!.frame.midY + 20)
            gameOverLoseNode.fontColor = UIColor.blackColor()
            self.addChild(gameOverLoseNode)
            
            let retryNode = SKLabelNode.init(text: "Retry")
            retryNode.position = CGPoint(x: self.view!.frame.midX - 75, y: self.view!.frame.midY - 30)
            retryNode.fontColor = UIColor.blackColor()
            retryNode.name = "retry"
            self.addChild(retryNode)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            if let nodeTouched = self.nodeAtPoint(location).name {
                if nodeTouched == "retry" {
                    restartLevel()
                }
                else if nodeTouched == "next" {
                    nextLevel()
                }
                else if nodeTouched == "quit" {
                    quit()
                }
            }
        }
    }
    
    func restartLevel() {
        viewController.replayLevel()
    }
    
    func nextLevel() {
        viewController.loadNextLevel()
    }
    
    func quit() {
        viewController.loadMenu()
    }
}

