//
//  MainViewController.swift
//  circles
//
//  Created by Gareth Carless on 10/04/2016.
//  Copyright © 2016 Gareth Carless. All rights reserved.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        //let secondViewController = GameViewController(nibName: nil, bundle: nil)
        //self.presentViewController(secondViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadLevel(level: Int) {
        let secondViewController = GameViewController(nibName: nil, bundle: nil)
        secondViewController.setLevel(level)
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        loadLevel(Int(sender.currentTitle!)!)
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
