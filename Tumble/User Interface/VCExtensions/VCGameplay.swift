//
//  VCGameplay.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import UIKit

extension ViewController {
    
    func startGameplay() {
        
        //MARK: - Prepare Gameplay
        
        setUpVisuals()
        addGestures()
        
        
        //MARK: - Start Gameplay
        gameService.delegate = self
        gameService.setUpBoard()
        enableUserInteraction()
    }
    
    func stopGameplay() {
        gameService.saveState()
    }
    
    func enableUserInteraction() {
        enableButtons()
        enableRotation()
    }
    
    func disableUserInteraction() {
        disableButtons()
        disableRotation()
    }
    
    func handleCWRotation() {
        disableUserInteraction()
        tiles = Util.rotateCW(grid: tiles) as! [[Tile?]]
        backTiles = Util.rotateCW(grid: backTiles) as! [[BackTile?]]
        gameService.handleCWRotation()
    }
    
    func handleCCWRotation() {
        disableUserInteraction()
        tiles = Util.rotateCCW(grid: tiles) as! [[Tile?]]
        backTiles = Util.rotateCCW(grid: backTiles) as! [[BackTile?]]
        gameService.handleCCWRotation()
    }
    
}
