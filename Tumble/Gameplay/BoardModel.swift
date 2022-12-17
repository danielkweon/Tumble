//
//  BoardModel.swift
//  Tumble
//
//  Created by Daniel Kweon on 1/25/21.
//

import Foundation

struct Drop {
    let rowDrop: Int
    let willMergeTo: Int?
}

struct Drops {
    let grid: [[Drop?]]
}

class BoardModel {
        
    var tiles: [[Int]]
    var size: Int
    var grid: GridDefaults
    
    var previousTiles: [[Int]]? = nil
    var waitToMerge: [[Int]] = []
    var emptyTiles: [[Int]] = []
    

    init(newTiles: Bool = false ) {
        grid = Defaults.get(key: Defaults.key_grid) as! GridDefaults
        size = grid.grid.size
        
        tiles = grid.grid.layout
        emptyTiles = grid.grid.layout

//        tiles = newTiles ? emptyTiles :
//            Defaults.get(key: Defaults.key_board) as! [[Int]]
//        emptyTiles = clearedTiles(tiles: tiles)
//
//        if size != tiles.count || didLose() {
//            tiles = emptyTiles;
//        }
        if isEmpty() {
            _ = addRandomTile()
        }
    }
    
    func clearedTiles(tiles: [[Int]]) -> [[Int]] {
        var clearedTiles: [[Int]] = []
        for row in 0 ..< tiles.count {
            var clearedRow: [Int] = []
            for col in 0 ..< tiles[row].count {
                if tiles[row][col] == -1 {
                    clearedRow.append(tiles[row][col])
                } else {
                    clearedRow.append(0)
                }
            }
            clearedTiles.append(clearedRow)
        }
        return clearedTiles
    }
            
    
    //MARK: - Board Rotations
    
    func rotateCCW() {
        savePreviousState()
        tiles = Util.rotateCCW(grid: tiles) as! [[Int]]
    }
    
    func rotateCW() {
        savePreviousState()
        tiles = Util.rotateCW(grid: tiles) as! [[Int]]
    }
    
    
    //MARK: - Drop Handling
    
    func droppable() -> Bool {
        for row in 0 ..< size - 1 {
        for col in 0 ..< size {
            if tiles[row][col] != 0 &&
                tiles[row][col] != -1 &&
                (tiles[row + 1][col] == 0 ||
                tiles[row][col] == tiles[row + 1][col]) {
                return true
            }
        }
        }
        return false
    }
    
    func dropTile(coordinate: Coordinate) -> Drop? {
        let (row, col) = (coordinate.row, coordinate.col)
        if tiles[row][col] == 0 ||
            tiles[row][col] == -1 {
            return nil
        }

        var tilesDropped: Int = 0
        var willMergeTo: Int? = nil
        for i in (row + 1) ..< size {
            if tiles[i][col] == -1 {
                break
            }
            if tiles[i][col] == 0 {
                tilesDropped += 1
            }
            else {
                if tiles[i][col] == tiles[row][col] {
                    if waitToMerge[i][col] == 0 {
                        waitToMerge[i][col] = 1
                        willMergeTo = tiles[row][col] * 2
                        tilesDropped += 1
                    } else {
                        waitToMerge[i - 1][col] = 1
                    }
                }
                break
            }
        }
        if tilesDropped == 0 {
            return nil
        }
        
        tiles[row + tilesDropped][col] =
            willMergeTo != nil ? willMergeTo! :tiles[row][col]
        tiles[row][col] = 0
        return Drop(rowDrop: tilesDropped, willMergeTo: willMergeTo)
    }
    
    func dropTiles() -> [Drops] {
        var drops: [Drops] = []
        while droppable() {
            waitToMerge = [[Int]](repeating: [Int](repeating: 0, count: size),
                                  count: size)
            var drop: [[Drop?]] = []
            for row in (0 ..< size).reversed() {
                var dropRow: [Drop?] = []
                for col in 0 ..< size {
                    dropRow.append(
                        dropTile(coordinate: Coordinate(row: row, col: col)))
                }
                drop.append(dropRow)
            }
            drops.append(Drops(grid: drop.reversed()))
        }
        print("dropTiles")
        Util.printBoard(grid: tiles)
        return drops
    }
    
    func addRandomTile() -> (Coordinate, Int) {
        var freeTiles: [Coordinate] = []
        for row in 0 ..< size {
        for col in 0 ..< size {
            if tiles[row][col] == 0 {
                freeTiles.append(Coordinate(row: row, col: col))
            }
        }
        }
        let value = Int.random(in: 0...100) < 85 ? 2 : 4
        let coord = freeTiles.randomElement()!
        tiles[coord.row][coord.col] = value
        
        print("addRandomTile")
        Util.printBoard(grid: tiles)
        return (coord, value)
    }

    
    //MARK: - Game State
    
    func undo() -> [[Int]]? {
        if previousTiles != nil {
            tiles = previousTiles!
            previousTiles = nil
            return tiles
        }
        return nil
    }

    func isEmpty() -> Bool {
        for row in 0 ..< size {
        for col in 0 ..< size {
            if tiles[row][col] != 0 &&
                tiles[row][col] != -1 {
                return false
            }
        }
        }
        return true
    }
    
    func didLose() -> Bool {
        for row in 0 ..< size {
        for col in 0 ..< size {
            if (col >= 1 && tiles[row][col] == tiles[row][col - 1])
                || (tiles[row][col] == 0) {
                return false
            }
        }
        }
        return true
    }
        
    func savePreviousState() {
        previousTiles = tiles
    }
    
    func saveState() {
        Defaults.set(key: Defaults.key_board, value: tiles)
    }
    
}
