//
//  VCGameplay.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import UIKit

extension ViewController {
    
    func startGameplay() {
        
        //MARK: - Prepare Gameplay
        
        setUpVisuals()
        addGestures()
        
        
        //MARK: - Start Gameplay
        
        enableUserInteraction()
    }
    
    func stopGameplay() {
    }
    
    func enableUserInteraction() {
        enableButtons()
        enableRotation()
    }
    
    func disableUserInteraction() {
        disableButtons()
        disableRotation()
    }
    
    func handleCWRotation() {
        disableUserInteraction()
    }
    
    func handleCCWRotation() {
        disableUserInteraction()
    }
    
}
