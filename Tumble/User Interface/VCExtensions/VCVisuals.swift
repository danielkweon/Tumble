//
//  VCVisuals.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import UIKit

extension ViewController {
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func setUpVisuals() {
        prettify()
    }

    func prettify() {
        view_board.layoutIfNeeded()
        button_undo.layoutIfNeeded()
        button_clear.layoutIfNeeded()

        button_undo.layer.cornerRadius = button_undo.frame.width / 8.0
        button_clear.layer.cornerRadius = button_clear.frame.width / 8.0
        view_board.layer.cornerRadius = view_board.frame.width / 30.0
        
        view_board.transform = CGAffineTransform(rotationAngle: 0.0)
    }
    
    func addEmptyTilesToBoard(size: Int, layout: [[Int]]) {
        for row in 0 ..< size {
            var backTileRow: [BackTile?] = []
            let _row = CGFloat(row)
            
            for col in 0 ..< size {
                
                if layout[row][col] == -1 {
                    backTileRow.append(nil)
                    continue
                }

                let _col = CGFloat(col)
                let _boardSize = CGFloat(size)
                
                let tileSpacing = view_board.frame.width / 42.0
                let tileSize = (view_board.frame.width
                                    - ((_boardSize + 1.0) * tileSpacing)) / _boardSize
                let origin = CGPoint(x: tileSpacing + _col
                                        * (tileSize + tileSpacing),
                                     y: tileSpacing + _row
                                        * (tileSize + tileSpacing))
                let bTile = BackTile(frame: CGRect(origin: origin,
                                                size: CGSize(width: tileSize, height: tileSize)))
                backTileRow.append(bTile)
                view_board.addSubview(bTile)
            }
            backTiles.append(backTileRow)
        }
        
        for row in 0 ..< size {
            var tileRow: [Tile?] = []
            for col in 0 ..< size {
                tileRow.append(addHiddenTile(coord: Coordinate(row: row, col: col)))
            }
            tiles.append(tileRow)
        }
    }
    
    func addHiddenTile(coord: Coordinate) -> Tile? {
        if backTiles[coord.row][coord.col] == nil {
            return nil
        }
        
        let tile = Tile(frame: backTiles[coord.row][coord.col]!.frame)
        
        let labelCCWRotations = (4 - gameService.CCWRotations) % 4
        let labelRadians = 90.0 / 180.0 * CGFloat.pi * CGFloat(labelCCWRotations)
        tile.label.transform = CGAffineTransform(rotationAngle: labelRadians)
        
        view_board.addSubview(tile)
        return tile
    }
    
    func setUpTiles(tileValues: [[Int]]) {
        for row in 0 ..< tiles.count {
        for col in 0 ..< tiles[row].count {
            if tileValues[row][col] != 0 &&
                tileValues[row][col] != -1 {
                tiles[row][col]?.setActive(value: tileValues[row][col],
                                          colorDefault: Defaults.get(key: Defaults.key_color) as! ColorDefaults)
            } else {
                tiles[row][col]?.setHidden()
            }
            }
        }
    }
    
    func setUpLabel(currentScore: Int, bestScore: Int) {
        label_scoreValue.text = String(currentScore)
        label_bestScoreValue.text = String(bestScore)
    }
    
    func changeTileColors() {
        for row in 0 ..< tiles.count {
        for col in 0 ..< tiles.count {
            if tiles[row][col]?.value != 0 &&
               tiles[row][col]?.value != -1 {
                tiles[row][col]?.setActive(value: tiles[row][col]!.value,
                                          colorDefault: Defaults.get(key: Defaults.key_color) as! ColorDefaults)
            }
        }
        }
    }
    
}
