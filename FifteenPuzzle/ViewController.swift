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
        if DEBUG {
            let tag = sender.tag
            NSLog("tileSelected: \(tag)")
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board // get model from app delegate
        let pos = board!.getRowAndColumn(forTile: sender.tag)
        let buttonBounds = sender.bounds
        var buttonCenter = sender.center
        var slide = true
        if board!.canSlideTileUp(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.y -= buttonBounds.size.height
        } else if board!.canSlideTileDown(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.y += buttonBounds.size.height
        } else if board!.canSlideTileLeft(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.x -= buttonBounds.size.width
        } else if board!.canSlideTileRight(atRow: pos!.row, Column: pos!.column) {
            buttonCenter.x += buttonBounds.size.width
        } else {
            slide = false
        }
        
        if slide {  // update model and view
            board!.slideTile(atRow: pos!.row, atColumn: pos!.column)
            //sender.center = buttonCenter // animate later
            UIView.animate(withDuration:0.5, animations: {sender.center = buttonCenter})
            //if (board!.isSolved()) { throwAPartyOnWin() }
            
        }
        
    }
    
    // Connect to shuffle buton
    @IBAction func shuffleTiles(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let board = appDelegate.board
        board?.scramble(numTimes: appDelegate.numShuffles)
        self.boardView.setNeedsLayout() // will trigger layoutSubviews to be invoked
    }
    
   
    
    
    
}

