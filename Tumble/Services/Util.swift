//
//  Util.swift
//  Tumble
//
//  Created by Daniel Kweon on 1/24/21.
//

import UIKit

struct Coordinate {
    let row: Int
    let col: Int
}

class Util {

    static func rotateCW(grid: [[Any?]]) -> [[Any?]] {
        var rotatedGrid: [[Any?]] = []
        let gridSize = grid.count - 1
        for col in 0 ... gridSize {
            var newRow: [Any?] = []
            for row in (0 ... gridSize).reversed() {
                newRow.append(grid[row][col])
            }
            rotatedGrid.append(newRow)
        }
        return rotatedGrid
    }

    static func rotateCCW(grid: [[Any?]]) -> [[Any?]] {
        var rotatedGrid: [[Any?]] = []
        let gridSize = grid.count - 1
        for col in (0 ... gridSize).reversed() {
            var newRow: [Any?] = []
            for row in 0 ... gridSize {
                newRow.append(grid[row][col])
            }
            rotatedGrid.append(newRow)
        }
        return rotatedGrid
    }

    static func printBoard(grid: [[Int]]) {
        for row in 0 ..< grid.count {
            var rowPrint = ""
            for col in 0 ..< grid.count {
                rowPrint += String(grid[row][col]) + " "
            }
            print(rowPrint)
        }
        print("")
    }

}
