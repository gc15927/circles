//
//  GameScene.swift
//  circles
//
//  Created by Gareth Carless on 03/04/2016.
//  Copyright (c) 2016 Gareth Carless. All rights reserved.
//

import SpriteKit
import UIKit


class GameScene: SKScene {
    //Initial values for basic variables
    var rad = 40 //Input var
    var circlesClicked = 0
    var circlesDrawn = 0
    var viewHeight = 0
    var viewWidth = 0
    var lastUpdateTime: Double = 0
    var timeBetweenCircles: Double = 1 //Input var
    var timeSinceLastCircle: Double = 0
    var startingCircles = 0 //Input var
    var numberOfCircles = 20 //Input var
    var circlesDrawnPerTime = 1 //Input var
    var fadeTime: Float = 0.03 //Input var
    var level = 0
    var viewController: GameViewController!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.scaleMode = .ResizeFill
        self.backgroundColor = UIColor.whiteColor()
        //Pulls the screen dimensions and gives them to the variables
        viewHeight = Int(self.view!.frame.height)
        viewWidth = Int(self.view!.frame.width)
        circlesClicked = 0
        circlesDrawn = 0
        lastUpdateTime = 0
        timeSinceLastCircle = 0
        let levels = readInLevels()
        setLevelData(levels,currentLevel: level)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
    }
    
    func assignViewController(controller: GameViewController) {
        viewController = controller
    }
    
    func setLevelData(data: NSString, currentLevel: Int) {
        var lines = [NSString]()
        data.enumerateLinesUsingBlock({ (line, stop) -> () in
            lines.append(line)
        })
        lines.removeFirst(1)
        let levelData = lines.removeAtIndex(currentLevel-1)
        let levelDataArray = levelData.componentsSeparatedByString(" ").map{Double($0)!}
        rad = Int(levelDataArray[0])
        timeBetweenCircles = Double(levelDataArray[1])
        startingCircles = Int(levelDataArray[2])
        numberOfCircles = Int(levelDataArray[3])
        circlesDrawnPerTime = Int(levelDataArray[4])
        fadeTime = Float(levelDataArray[5])
    }
    
    func assignLevel(l: Int) {
        level = l
    }
    
    func readInLevels()->NSString {
        if let filepath = NSBundle.mainBundle().pathForResource("levels", ofType: "txt") {
            do {
                let contents = try NSString(contentsOfFile: filepath, usedEncoding: nil) as String
                return contents
            } catch {
                // contents could not be loaded
                print("contents not loaded")
            }
        } else {
            // levels.txt not found
            print("levels.txt not found")
        }
        return "failure"
    }
    
    func changeColourOfCircles() {
        //Scrolls through all the nodes currently on screen,
        //converts to a Circle and calls the changeColour() method
        //if the red value of its colour is not yet 1. If it is 1,
        //calls the gameOver() function.
        for tempNode in self.children {
            if((tempNode as! Circle).getColour().0 <= 1) {
                (tempNode as! Circle).changeColour()
            }
            else {
                gameOver(0)
                break
            }
            //Checks whether the node has been clicked, if it has
            //removes it from the scene and updates the circlesClicked
            //variable.
            if((tempNode as! Circle).clicked) {
                tempNode.removeFromParent()
                circlesClicked += 1
            }
        }
    }
    
    func gameOver(won: Int) {
        //Pauses game, prints end-game output
        self.removeAllChildren()
        self.paused = true
        if(won == 1) {
            viewController.displayGameOver(true)
        }
        else {
            viewController.displayGameOver(false)
        }
    }
    
//    func updateTimeBetween() {
//        let noCircles = Double(circlesClicked)
//        timeBetweenCircles = exp(-(noCircles/10))
//    }
    
    func newCircleNeeded(timeSinceUpdate: Double)->Bool {
    //Checks if enough time has passed for a new circle
        timeSinceLastCircle += timeSinceUpdate
        if(timeSinceLastCircle >= timeBetweenCircles && circlesDrawn < numberOfCircles) {
            timeSinceLastCircle = 0
            return true
        }
        else {
            return false
        }
    }
    
    func drawNewCircle() {
        //Generates random x and y coordinates within the allowed space
        //to ensure that the circles are completely within the screen, and
        //assigns them to a point for the circle
        for _ in 1...circlesDrawnPerTime {
            let newX = Int(arc4random_uniform(UInt32(viewWidth - rad*2)))
            let newY = Int(arc4random_uniform(UInt32(viewHeight - rad*2)))
            let newPoint = CGPoint.init(x: (Int(newX)), y: (Int(newY)))
            //Does the same for the radius, and generates a new Circle with the
            //data, before adding it to the scene
            let newCircle = Circle(circleOfRadius: rad, atPoint: newPoint)
            newCircle.setFade(fadeTime)
            self.addChild(newCircle)
            circlesDrawn += 1
        }
    }
    
    //Function to check whether a given circle overlaps with any other currently
    //on-screen. Not currently used, uncertain about usefulness but thought it
    //could be handy.
    func circleOverlapsOthers(circle: Circle)->Bool {
        for tempCircle in self.children {
            if(circle.intersectsNode(tempCircle)) {
                return true
            }
        }
        return false
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let timeSinceLastUpdate = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        changeColourOfCircles()
        if(circlesClicked == numberOfCircles) {
            gameOver(1)
        }
        if(newCircleNeeded(timeSinceLastUpdate)) {
            drawNewCircle()
        }
    }
}
