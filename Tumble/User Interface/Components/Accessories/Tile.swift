//
//  Tile.swift
//  Tumble
//
//  Created by Daniel Kweon on 12/15/22.
//

import UIKit

class Tile: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = layer.frame.width / 10.0
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
