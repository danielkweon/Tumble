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
    
}
