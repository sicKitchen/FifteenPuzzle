//
//  FifteenBoard.swift
//  FifteenPuzzle
//
//  Created by Spencer Kitchen on 2/10/17.
//  Copyright © 2017 wsu.vancouver. All rights reserved.
//

import Foundation


class FifteenBoard{
    
    var SOLVED:Bool = false
    
    // Turn on/off debug statements
    var DEBUG:Bool = true
    
    // Puzzle Board, 0 = empty slot on board
    var state : [[Int]] = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
        [13, 14, 15, 0]
    ]
    
    // Choose one of the “slidable” tiles at random and slide it into the empty 
    // space; repeat n times. We use this method to start a new game using a 
    // large value (e.g., 150) for n.
    func scramble(numTimes n : Int){
        let max : UInt32 = 15      // highest tile
        let min : Int = 1          // lowest tile
        
        // Check if tile is slidable by sliding n times
        var count = 0
        while count < n {
            // get random number
            let randNum = getRandNum(max, min)
            
            if DEBUG {NSLog("randNum \(randNum)")}
            
            // get the current tiles row and column
            if let tile = getRowAndColumn(forTile: randNum) {
                
                if DEBUG {NSLog("tile.row \(tile.row) tile.column \(tile.column)")}
                
                
                // check if we can slide the tile and perform it
                if canSlideTile(atRow: tile.row, Column: tile.column) {
                    slideTile(atRow: tile.row, atColumn: tile.column)
                    count += 1
                    
                }
            }
            if DEBUG {NSLog("Count \(count)")}
        }
        SOLVED = false
        
    }
    
    // Functions to check if tile can slide up, down, left, right
    // UP
    func canSlideTileUp(atRow r : Int, Column c : Int) -> Bool {
        //if DEBUG {NSLog("Tile above selected tile \(state[r-1][c])")}
        
        NSLog("in up function: R\(r)")
        
        if r == 0 {return false}
        
        // Check if tile can slide up
        if state[r-1][c] == 0  {return true}
    
        return false;
    }
    
    // DOWN
    func canSlideTileDown(atRow r : Int, Column c : Int) -> Bool {
        //if DEBUG {NSLog("Tile below selected tile \(state[r+1][c])")}
        
        NSLog("in down function: R \(r)")
        
        if r == 3 {return false}
        
        // Check if tile can slide down
        if state[r+1][c] == 0 {return true}
        
        return false
    }
    
    //LEFT
    func canSlideTileLeft(atRow r : Int, Column c : Int) -> Bool {
        //if DEBUG {NSLog("Tile to the left of selected tile \(state[r][c-1])")}
        
        NSLog("in left function")
        
        if c == 0 {return false}
        
        // Check if tile can slide left
        if state[r][c-1] == 0 {return true}
        
        return false
    }
    
    // RIGHT
    func canSlideTileRight(atRow r : Int, Column c : Int) -> Bool {
        //if DEBUG {NSLog("Tile to the right of selected tile \(state[r][c+1])")}
        
        NSLog("in right function")
        
        if c == 3 {return false}
        
        // Check if tile can slide right
        if state[r][c+1] == 0 {return true}
        
        return false
    }
    
    // Check if tile can slide into any empty space
    func canSlideTile(atRow r : Int, Column c : Int) -> Bool {
        
        let up = canSlideTileUp(atRow: r, Column: c)
        let down = canSlideTileDown(atRow: r, Column: c)
        let left = canSlideTileLeft(atRow: r, Column: c)
        let right = canSlideTileRight(atRow: r, Column: c)
        
        if up || down || left || right == true {return true}
        return false
    }
    
    // Slide tile function
    func slideTile(atRow r: Int, atColumn c:Int){
        
        let up = canSlideTileUp(atRow: r, Column: c)
        let down = canSlideTileDown(atRow: r, Column: c)
        let left = canSlideTileLeft(atRow: r, Column: c)
        let right = canSlideTileRight(atRow: r, Column: c)
        
        if up {
            // get current tile
            var current = getTile(atRow: r, atColumn: c)
            // get slide tile (where the 0 is)
            var slide = getTile(atRow: r-1, atColumn: c)
            // swap the current and the slide tile numbers
            let tmp = current
            current = slide
            slide = tmp
            // Set the new numbers to state
            state[r][c] = current
            state[r-1][c] = slide
        } else
            
        if down {
            // get current tile
            var current = getTile(atRow: r, atColumn: c)
            // get slide tile (where the 0 is)
            var slide = getTile(atRow: r+1, atColumn: c)
            // swap the current and the slide tile numbers
            let tmp = current
            current = slide
            slide = tmp
            // Set the new numbers to state
            state[r][c] = current
            state[r+1][c] = slide
        } else
                
        if left {
            // get current tile
            var current = getTile(atRow: r, atColumn: c)
            // get slide tile (where the 0 is)
            var slide = getTile(atRow: r, atColumn: c-1)
            // swap the current and the slide tile numbers
            let tmp = current
            current = slide
            slide = tmp
            // Set the new numbers to state
            state[r][c] = current
            state[r][c-1] = slide
        } else
                    
        if right {
            // get current tile
            var current = getTile(atRow: r, atColumn: c)
            // get slide tile (where the 0 is)
            var slide = getTile(atRow: r, atColumn: c+1)
            // swap the current and the slide tile numbers
            let tmp = current
            current = slide
            slide = tmp
            // Set the new numbers to state
            state[r][c] = current
            state[r][c+1] = slide
        }
        
        SOLVED = isSolved()

        
    }
    
    
    // Fetch the tile at the given position (0 is used for the space).
    func getTile(atRow r:Int, atColumn c:Int) -> Int {
        let currentTile = state[r][c]
        return currentTile
    }
    
    // Find the position of the given tile (0 is used for the space)
    // – returns tuple holding row and column.
    func getRowAndColumn(forTile tile: Int) -> (row: Int, column: Int)? {
        for row in 0...3  {
            for column in 0...3 {
                // get current tile
                let currentTile = state[row][column]
                if currentTile == tile {
                    return (row, column)
                }
            }
        }
        // if error occurs return negative 1
        return (-1, -1)
    }
    
    // Determine if puzzle is in solved configuration.
    func isSolved() -> Bool {
        // Loop over state and check if state is equal to truth
        // TRUTH
        var truth : [[Int]] = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
            [13, 14, 15, 0]
        ]
        
        for row in 0...3 {
            for column in 0...3 {
                if state[row][column] != truth[row][column] {
                    NSLog("Checking solution [\(row)][\(column)] not equal \n")
                    NSLog( "state: \(state)\n")
                    NSLog( "Truth: \(truth)\n")
                    return false
                }
            }
        }
        
        NSLog("PUZZLE SOLVED!")
        return true
    }
    
    // Random number generator
    func getRandNum(_ MAX: UInt32, _ MIN: Int) -> Int {
        // arc4random returns 0->MAX-1, Since we want MIN->MAX
        // we want to add MIN back into th random number
        let randomNumber:Int = (Int(arc4random_uniform(MAX)) + MIN)
        return randomNumber
    }
    
}


























