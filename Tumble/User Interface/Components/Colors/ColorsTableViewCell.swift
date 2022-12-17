//
//  ColorsTableViewCell.swift
//  Tumble
//
//  Created by Daniel Kweon on 12/15/22.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {

    //MARK: - User Interface Components
    
    @IBOutlet weak var view_board: UIView!
    
    @IBOutlet weak var button_unlock        : UIButton!
    @IBOutlet weak var button_select        : UIButton!
    @IBOutlet weak var button_selected      : UIButton!
    
    
    //MARK: - Variable
    
    var delegate: ColorsViewController?

    var tiles               : [[BackTile]] = []
    var tileValues          : [Int] = [2, 4, 8, 16]
    var color: ColorDefaults? {
        didSet {
            view_board.layer.cornerRadius = view_board.frame.width / 30.0
            addTilesToBoard()
            setButtonText()
        }
    }
    

    //MARK: - Set Up
    
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
        
        var tileIndex = 0
        let size = 2, tileSpacing = view_board.frame.width / 42.0
        for row in 0 ..< size {
            var tileRow: [BackTile] = []
            for col in 0 ..< size {
                let tileSize = (view_board.frame.width
                                - ((CGFloat(size) + 1.0) * tileSpacing)) / CGFloat(size)
                let origin = CGPoint(x: tileSpacing + CGFloat(col)
                                        * (tileSize + tileSpacing),
                                     y: tileSpacing + CGFloat(row)
                                        * (tileSize + tileSpacing))
                let tile = BackTile(frame: CGRect(origin: origin,
                                              size: CGSize(width: tileSize, height: tileSize)))
                let (_, backgroundColor) = Colors.colorFor(value: tileValues[tileIndex],
                                                            colorDefault: color!)
                tile.backgroundColor = backgroundColor
                view_board.addSubview(tile)
                tileRow.append(tile)
                tileIndex += 1
            }
            tiles.append(tileRow)
        }
    }
    
    func setButtonText() {
        if Defaults.get(key: Defaults.key_color) as! ColorDefaults == color! {
            button_unlock.isHidden   = true
            button_select.isHidden   = true
            button_selected.isHidden = false
        } else if (Defaults.get(key: Defaults.key_unlockedColors) as! [String]).contains(color!.description) {
            button_unlock.isHidden   = true
            button_select.isHidden   = false
            button_selected.isHidden = true
        }
    }
    
    
    //MARK: - Button Actions
    
    @IBAction func unlockButtonPressed(_ sender: Any) {
        var unlockedColors = Defaults.get(key: Defaults.key_unlockedColors) as! [String]
        unlockedColors.append(color!.description)
        Defaults.set(key: Defaults.key_unlockedColors, value: unlockedColors)
        
        self.delegate?.table_colors.reloadData()
        //TODO
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        Defaults.set(key: Defaults.key_color, value: color!.rawValue)

        self.delegate?.table_colors.reloadData()
    }
    
}

