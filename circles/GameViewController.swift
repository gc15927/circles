//
//  GameViewController.swift
//  circles
//
//  Created by Gareth Carless on 10/04/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var currentLevel = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView: SKView = SKView.init(frame: self.view.frame)
            self.view.addSubview(skView)
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.assignLevel(currentLevel)
            scene.assignViewController(self)
            
            skView.presentScene(scene)
        }
    }
    
    func setLevel(level: Int) {
        currentLevel = level
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayGameOver(won: Bool) {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        let scene = GameOverScene()
            // Configure the view.
            let skView: SKView = SKView.init(frame: self.view.frame)
            self.view.addSubview(skView)
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.assignViewController(self)
            scene.hasWon = won
            skView.presentScene(scene)
    }

    func replayLevel() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView: SKView = SKView.init(frame: self.view.frame)
            self.view.addSubview(skView)
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.assignLevel(currentLevel)
            scene.assignViewController(self)
            
            skView.presentScene(scene)
        }
    }
    
    func loadNextLevel() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView: SKView = SKView.init(frame: self.view.frame)
            self.view.addSubview(skView)
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            currentLevel += 1
            scene.assignLevel(currentLevel)
            scene.assignViewController(self)
            
            skView.presentScene(scene)
        }
    }
    
    func loadMenu() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        let menuViewController = MainViewController(nibName: nil, bundle: nil)
        self.presentViewController(menuViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
