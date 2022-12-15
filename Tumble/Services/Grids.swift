//
//  Grids.swift
//  Tumble
//
//  Created by Daniel Kweon on 12/12/22.
//

import Foundation

struct Grid {
    let size    : Int
    let layout  : [[Int]]
}

enum GridDefaults: Int,
                    CaseIterable,
                    CustomStringConvertible
{
    case grid0
    case grid1
    case grid2
    case grid3
    case grid4
    case grid5
    case grid6
    case grid7

    var description: String {
        switch self {
        case .grid0:
            return "grid0"
        case .grid1:
            return "grid1"
        case .grid2:
            return "grid2"
        case .grid3:
            return "grid3"
        case .grid4:
            return "grid4"
        case .grid5:
            return "grid5"
        case .grid6:
            return "grid6"
        case .grid7:
            return "grid7"
        }
    }
    
    var details: String {
        switch self {
        case .grid0:
            return "4x4 Full"
        case .grid1:
            return "4x4 without Corners"
        case .grid2:
            return "4x4 without Center"
        case .grid3:
            return "5x5 Full"
        case .grid4:
            return "5x5 without 2 Corners"
        case .grid5:
            return "5x5 without 4 Center"
        case .grid6:
            return "5x5 without Center"
        case .grid7:
            return "5x5 without 2 Corners 2"
        }
    }
    
    var grid: Grid {
        switch self {
        case .grid0:
            return Grid(size    : 4,
                        layout  : [[ 0,  0,  0,  0],
                                   [ 0,  0,  0,  0],
                                   [ 0,  0,  0,  0],
                                   [ 0,  0,  0,  0]])
        case .grid1:
            return Grid(size    : 4,
                        layout  : [[ 0,  0,  0, -1],
                                   [ 0,  0,  0,  0],
                                   [ 0,  0,  0,  0],
                                   [-1,  0,  0,  0]])
        case .grid2:
            return Grid(size    : 4,
                        layout  : [[ 0,  0,  0,  0],
                                   [ 0,  0, -1,  0],
                                   [ 0, -1,  0,  0],
                                   [ 0,  0,  0,  0]])
        case .grid3:
            return Grid(size    : 5,
                        layout  : [[ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0]])

        case .grid4:
            return Grid(size    : 5,
                        layout  : [[ 0,  0,  0,  0, -1],
                                   [ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0],
                                   [-1,  0,  0,  0,  0]])

        case .grid5:
            return Grid(size    : 5,
                        layout  : [[-1,  0,  0,  0, -1],
                                   [ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0],
                                   [-1,  0,  0,  0, -1]])

        case .grid6:
            return Grid(size    : 5,
                        layout  : [[ 0,  0,  0,  0,  0],
                                   [ 0,  0,  0, -1,  0],
                                   [ 0,  0, -1,  0,  0],
                                   [ 0, -1,  0,  0,  0],
                                   [ 0,  0,  0,  0,  0]])
            
        case .grid7:
            return Grid(size    : 5,
                        layout  : [[ 0,  0,  0, -1, -1],
                                   [ 0,  0,  0,  0, -1],
                                   [ 0,  0,  0,  0,  0],
                                   [-1,  0,  0,  0,  0],
                                   [-1, -1,  0,  0,  0]])
        }
    }
}
