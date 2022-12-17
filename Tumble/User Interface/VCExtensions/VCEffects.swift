//
//  VCAnimations.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import Foundation
import UIKit

extension ViewController {

    func handleAnimations(drops: [Drops], CCWRotations: Int) {
        var delay = Constants.duration_rotation * 0.95
        animateBoardRotation(CCWRotations: CCWRotations)

        if drops.isEmpty {
            delay += Constants.delay_minimum
        } else {
            for i in 0 ..< drops.count {
                Timer.scheduledTimer(withTimeInterval: delay,
                                     repeats: false) { _ in
                    self.dropTiles(drop: drops[i])
                }
                if drops.count > 1 {
                    delay += Constants.delay_pop + Constants.duration_pop
                } else {
                    delay += Constants.duration_drop
                }
            }
        }
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            self.gameService.postDrops()
        }
    }

    func dropTiles(drop: Drops) {
        var scoreIncrease = 0
        for row in (0 ..< tiles.count).reversed() {
        for col in 0 ..< tiles.count {
        if let toDrop = drop.grid[row][col] {
            let source = Coordinate(row: row, col: col)
            let destinationRow = row + toDrop.rowDrop
            animateTileDrop(coord: source, drop: toDrop)
            if let mergeValue = toDrop.willMergeTo {
                scoreIncrease += mergeValue / 2
                animateTileMerge(tile: tiles[row][col]!,
                                 dest: Coordinate(row: destinationRow, col: col),
                                 mergeValue: mergeValue)
                tiles[row][col] = addHiddenTile(coord: source)
            } else {
                tiles[destinationRow][col]!.removeFromSuperview()
                tiles[destinationRow][col] = tiles[row][col]
                tiles[row][col] = addHiddenTile(coord: source)
            }
        }
        }
        }
        if scoreIncrease != 0 {
            gameService.currentScore += scoreIncrease
            var bestScoreBeat = false
            if gameService.currentScore > gameService.bestScore {
                gameService.bestScore = gameService.currentScore
                bestScoreBeat = true
            }
            updateLabel(currentScore: gameService.currentScore, bestScoreBeat: bestScoreBeat)
        }
    }

    func animateBoardRotation(CCWRotations: Int) {
        let boardRadians = 90.0 / 180.0 * CGFloat.pi * CGFloat(CCWRotations)
        let labelCCWRotations = (4 - CCWRotations) % 4
        let labelRadians = 90.0 / 180.0 * CGFloat.pi * CGFloat(labelCCWRotations)

        UIView.animate(withDuration: Constants.duration_rotation) {
            self.view_board.transform = CGAffineTransform(rotationAngle: boardRadians)
            for row in 0 ..< self.tiles.count {
                for col in 0 ..< self.tiles.count {
                    self.tiles[row][col]?.label.transform = CGAffineTransform(rotationAngle: labelRadians)
                }
            }
        }
    }

    func popInTile(coord: Coordinate, completionHandler: ((Bool) -> Void)? ) {
        tiles[coord.row][coord.col]!.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        view_board.bringSubviewToFront(tiles[coord.row][coord.col]!)
        UIView.animate(withDuration: Constants.duration_pop,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 6.5,
                       options: .curveEaseOut,
                       animations: {
                        self.tiles[coord.row][coord.col]!.transform = CGAffineTransform(scaleX: 1, y: 1)
                       }, completion: completionHandler)
    }

    func animateTileDrop(coord: Coordinate, drop: Drop) {
        let movingTile = tiles[coord.row][coord.col]!
        let destinationRow = coord.row + drop.rowDrop
        let destinationTile = backTiles[destinationRow][coord.col]!

        view_board.bringSubviewToFront(movingTile)
        UIView.animate(withDuration: Constants.duration_drop,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 4,
                       options: .curveEaseOut,
                       animations: {
                        movingTile.frame.origin = destinationTile.frame.origin
                       }, completion: nil )
    }

    func animateTileMerge(tile: Tile, dest: Coordinate, mergeValue: Int) {
        Timer.scheduledTimer(withTimeInterval: Constants.delay_pop, repeats: false) { _ in
            self.tiles[dest.row][dest.col]!.setActive(value: mergeValue,
                colorDefault: Defaults.get(key: Defaults.key_color) as! ColorDefaults)
            self.popInTile(coord: Coordinate(row: dest.row, col: dest.col), completionHandler: { _ in
                tile.removeFromSuperview()
            })
        }
    }

    func animateShakeUndo() {
        button_undo.transform = CGAffineTransform(translationX: button_undo.frame.width / 4, y: 0)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: {
                        self.button_undo.transform = CGAffineTransform.identity
                       }, completion: nil)
    }

    func addRandomTile(coord: Coordinate, value: Int) {
        tiles[coord.row][coord.col]!.setActive(value: value,
            colorDefault: Defaults.get(key: Defaults.key_color) as! ColorDefaults)
        popInTile(coord: coord, completionHandler: nil)
    }

    func updateLabel(currentScore: Int, bestScoreBeat: Bool) {
        let scaleValue = CGFloat(2.25)
        Timer.scheduledTimer(withTimeInterval: Constants.delay_pop, repeats: false) { _ in
            if bestScoreBeat {
                UIView.animate(withDuration: Constants.duration_pop, animations: {
                    self.label_scoreValue.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
                    self.label_bestScoreValue.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)

                    self.label_scoreValue.text = String(currentScore)
                    self.label_bestScoreValue.text = String(currentScore)
                }, completion: nil)
                UIView.animate(withDuration: Constants.duration_pop, animations: {
                    self.label_scoreValue.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.label_bestScoreValue.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: Constants.duration_pop, animations: {
                    self.label_scoreValue.transform = CGAffineTransform(scaleX: scaleValue, y: scaleValue)
                    self.label_scoreValue.text = String(currentScore)
                }, completion: nil)
                UIView.animate(withDuration: Constants.duration_pop, animations: {
                    self.label_scoreValue.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        }
    }

}
