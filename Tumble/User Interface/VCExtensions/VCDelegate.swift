//
//  VCDelegate.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import Foundation

extension ViewController: GameServiceDelegate {
    
    func _setUpBoard(size: Int, layout: [[Int]]) {
        for row in 0 ..< self.tiles.count {
            for col in 0 ..< self.tiles.count {
                tiles[row][col]?.removeFromSuperview()
            }
        }
        tiles = []

        for row in 0 ..< self.backTiles.count {
            for col in 0 ..< self.backTiles.count {
                backTiles[row][col]?.removeFromSuperview()
            }
        }
        backTiles = []
        
        view_board.transform = CGAffineTransform(rotationAngle: 0.0)
        addEmptyTilesToBoard(size: size, layout: layout)
    }
    
    func _setUpTiles(tileValues: [[Int]]) {
        setUpTiles(tileValues: tileValues)
    }
    
    func _handleRotation(drops: [Drops], CCWRotations: Int) {
        handleAnimations(drops: drops, CCWRotations: CCWRotations)
    }
    
    func _addRandomTile(coord: Coordinate, value: Int) {
        addRandomTile(coord: coord, value: value)
    }
    
    func _setUpLabel(currentScore: Int, bestScore: Int) {
        setUpLabel(currentScore: currentScore, bestScore: bestScore)
    }
    
    func _shakeUndo() {
        animateShakeUndo()
    }
    
    func _handleGameOver() {
        handleGameOver()
    }
    
    func _enableUserInteraction() {
        enableUserInteraction()
    }
    
}
