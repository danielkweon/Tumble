//
//  GameService.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import Foundation

protocol GameServiceDelegate {
    func _setUpLabel(currentScore: Int, bestScore: Int)
    func _setUpBoard(size: Int, layout: [[Int]])
    func _setUpTiles(tileValues: [[Int]])
    func _handleRotation(drops: [Drops], CCWRotations: Int)
    func _addRandomTile(coord: Coordinate, value: Int)
    func _shakeUndo()
    func _handleGameOver()
    func _enableUserInteraction()
}

class GameService {
    
    //MARK: - Variables

    var delegate: GameServiceDelegate?
    
    var boardModel: BoardModel
    var grid: GridDefaults
    var CCWRotations: Int         = 0
    
    var currentScore: Int
    var bestScores: [String: Int]
    var bestScore: Int
    var previousCurrentScore: Int   = 0
    var previousBestScore: Int      = 0
    
    //MARK: - Initialization
    
    init() {
        grid = Defaults.get(key: Defaults.key_grid) as! GridDefaults
        boardModel = BoardModel()
        
        currentScore = Defaults.get(key: Defaults.key_score) as! Int
        bestScores = Defaults.get(key: Defaults.key_bestScores) as! [String: Int]
        bestScore = bestScores[grid.description]!
    }

    func setUpBoard() {
        delegate?._setUpLabel(currentScore: currentScore, bestScore: bestScore)
        delegate?._setUpBoard(size: grid.grid.size, layout: boardModel.emptyTiles)
        delegate?._setUpTiles(tileValues: boardModel.tiles)
    }
    
    
    //MARK: - Gameplay Handling
    
    func handleCWRotation() {
        CCWRotations += 1
        CCWRotations %= 4
        
        boardModel.rotateCW()
        handleRotation()
    }
    
    func handleCCWRotation() {
        CCWRotations += 3
        CCWRotations %= 4
        
        boardModel.rotateCCW()
        handleRotation()
    }
    
    func handleRotation() {
        delegate?._handleRotation(drops: boardModel.dropTiles(),
                                  CCWRotations: CCWRotations)
    }
    
    func postDrops() {
        let (coord, value) = boardModel.addRandomTile()
        delegate?._addRandomTile(coord: coord, value: value)
        if boardModel.didLose() {
            handleGameOver()
        } else {
            delegate?._enableUserInteraction()
        }
    }
    
    func handleGameOver() {
        delegate?._handleGameOver()
    }
    

    //MARK: - Gameplay State
    
    func undo() {
        if let previousTiles = boardModel.undo() {
            delegate?._setUpTiles(tileValues: previousTiles)
        } else {
            delegate?._shakeUndo()
        }
    }
    
    func clearStats() {
        currentScore = 0
        previousCurrentScore = 0
        previousBestScore = 0
    }
    
    func clear() {
        CCWRotations = 0
        clearStats()
        grid = Defaults.get(key: Defaults.key_grid) as! GridDefaults
        boardModel = BoardModel(newTiles: true)
        
        currentScore = Defaults.get(key: Defaults.key_score) as! Int
        bestScores = Defaults.get(key: Defaults.key_bestScores) as! [String: Int]
        bestScore = bestScores[grid.description]!
        setUpBoard()
    }
    
    func saveState() {
        bestScores[grid.description] = bestScore
        boardModel.saveState()
        Defaults.set(key: Defaults.key_score, value: currentScore)
        Defaults.set(key: Defaults.key_bestScores, value: bestScores)
    }
    
}
