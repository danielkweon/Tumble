//
//  GridsTableViewCell.swift
//  Tumble
//
//  Created by Daniel Kweon on 12/14/22.
//

import UIKit

class GridsTableViewCell: UITableViewCell {

    // MARK: - User Interface Components

    @IBOutlet weak var view_board: UIView!

    @IBOutlet weak var button_unlock: UIButton!
    @IBOutlet weak var button_select: UIButton!
    @IBOutlet weak var button_selected: UIButton!

    // MARK: - Variable

    var delegate: GridsViewController?

    var tiles: [[BackTile]] = []
    var grid: GridDefaults? {
        didSet {
            view_board.layer.cornerRadius = view_board.frame.width / 30.0
            addTilesToBoard()
            setButtonText()
        }
    }

    // MARK: - Set Up

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        for row in 0 ..< tiles.count {
            for col in 0 ..< tiles[row].count {
                tiles[row][col].removeFromSuperview()
            }
        }
        tiles = []

        button_unlock.isHidden   = false
        button_select.isHidden   = true
        button_selected.isHidden = true
    }

    func addTilesToBoard() {
        view_board.layoutIfNeeded()

        let size = grid!.grid.size, layout = grid!.grid.layout
        let tileSpacing = view_board.frame.width / 42.0
        for row in 0 ..< size {
            var tileRow: [BackTile] = []
            for col in 0 ..< size {
                if layout[row][col] == -1 {
                    continue
                }

                let tileSize = (view_board.frame.width
                                - ((CGFloat(size) + 1.0) * tileSpacing)) / CGFloat(size)
                let origin = CGPoint(x: tileSpacing + CGFloat(col)
                                        * (tileSize + tileSpacing),
                                     y: tileSpacing + CGFloat(row)
                                        * (tileSize + tileSpacing))
                let tile = BackTile(frame: CGRect(origin: origin,
                                              size: CGSize(width: tileSize, height: tileSize)))
                view_board.addSubview(tile)
                tileRow.append(tile)
            }
            tiles.append(tileRow)
        }
    }

    func setButtonText() {
        if (Defaults.get(key: Defaults.key_grid) as! GridDefaults).description == grid!.description {
            button_unlock.isHidden   = true
            button_select.isHidden   = true
            button_selected.isHidden = false
        } else if (Defaults.get(key: Defaults.key_unlockedGrids) as! [String]).contains(grid!.description) {
            button_unlock.isHidden   = true
            button_select.isHidden   = false
            button_selected.isHidden = true
        }
    }

    // MARK: - Button Actions

    @IBAction func unlockButtonPressed(_ sender: Any) {
        var unlockedGrids = Defaults.get(key: Defaults.key_unlockedGrids) as! [String]
        unlockedGrids.append(grid!.description)
        Defaults.set(key: Defaults.key_unlockedGrids, value: unlockedGrids)

        self.delegate?.table_grids.reloadData()
    }

    @IBAction func selectButtonPressed(_ sender: Any) {
        Defaults.set(key: Defaults.key_grid, value: grid!.rawValue)

        self.delegate?.table_grids.reloadData()
        delegate?.completionHandler()
    }

}
