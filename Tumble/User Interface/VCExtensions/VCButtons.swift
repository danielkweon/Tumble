//
//  VCButtons.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import UIKit

extension ViewController {
    
    //MARK: - Button Handling
    
    func enableButtons() {
        buttonsEnabled = true
        button_undo.isUserInteractionEnabled = true
        button_clear.isUserInteractionEnabled = true
    }
    
    func disableButtons() {
        buttonsEnabled = false
        button_undo.isUserInteractionEnabled = false
        button_clear.isUserInteractionEnabled = false
    }
    
    func hideButtons() {
        button_undo.isHidden = true
        button_clear.isHidden = true
    }
    
    func showButtons() {
        button_undo.isHidden = false
        button_clear.isHidden = false
    }
    
    
    //MARK: - Rotation Buttons
    
    @IBAction func rotateCWButtonPressed(_ sender: UIButton) {
        handleCWRotation()
    }
    
    @IBAction func rotateCCWButtonPressed(_ sender: UIButton) {
        handleCCWRotation()
    }

    
    //MARK: - Gameplay Buttons

    @IBAction func undoButtonPressed(_ sender: UIButton) {
        if buttonsEnabled {
            disableUserInteraction()
            // Handle Undo
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        if buttonsEnabled {
            disableUserInteraction()
            // Handle Clear
        }
    }
    
}
