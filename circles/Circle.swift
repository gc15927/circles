//
//  Circle.swift
//  circles
//
//  Created by Gareth Carless on 03/04/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import Foundation
import SpriteKit

class Circle: SKShapeNode {
    var redVal: Float
    var blueVal: Float
    var clicked: Bool
    var fadeTimeCoefficient: Float
    
    //Initialises a circle at a given point with a given radius
    //with initially a blue colour
    init(circleOfRadius: Int, atPoint: CGPoint) {
        redVal = 0
        blueVal = 1
        clicked = false
        fadeTimeCoefficient = 0.03
        super.init()
        self.userInteractionEnabled = true
        let diameter = circleOfRadius * 2
        self.path = CGPathCreateWithEllipseInRect(CGRect(origin: atPoint, size: CGSize(width: diameter, height: diameter)), nil)
        self.fillColor = UIColor.init(colorLiteralRed: redVal, green: 0, blue: blueVal, alpha: 1)
        self.strokeColor = UIColor.init(colorLiteralRed: redVal, green: 0, blue: blueVal, alpha: 1)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Getter for the colour
    func getColour()->(Float,Float) {
        return (redVal,blueVal)
    }
    
    //Getter for clicked
    func getClicked()->Bool {
        return clicked
    }
    
    //Setter for the time fade
    func setFade(time: Float) {
        fadeTimeCoefficient = time
    }
    
    func changeColour() {
        //Reduces the blue pigment of the colour, increases the red
        //to gradually change the colour of the circle to red
        redVal += fadeTimeCoefficient
        blueVal -= fadeTimeCoefficient
        //Updates the fill and stroke accordingly
        self.fillColor = UIColor.init(colorLiteralRed: redVal, green: 0, blue: blueVal, alpha: 1)
        self.strokeColor = UIColor.init(colorLiteralRed: redVal, green: 0, blue: blueVal, alpha: 1)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Sets the clicked variable to true so that the parent
        //scene can check whether it should be removed
        clicked = true
    }

}
