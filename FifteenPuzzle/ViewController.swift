//
//  ViewController.swift
//  FifteenPuzzle
//
//  Created by Spencer Kitchen on 2/10/17.
//  Copyright © 2017 wsu.vancouver. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Turn on/off debug statements
    var DEBUG:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Connect to BoardView
    @IBOutlet weak var boardView: BoardView!
    
    // Connect to all 15 buttons
    @IBAction func tileSelected(_ sender: UIButton) {
        let tag = sender.tag
        NSLog("tileSelected: \(tag)")
    }
    
    // Connect to shuffle buton
    @IBAction func shuffleTiles(_ sender: AnyObject) { }
    
   
    
    
}

