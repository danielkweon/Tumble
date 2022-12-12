//
//  VCGestures.swift
//  Tumble
//
//  Created by Daniel Kweon on 1/25/21.
//

import UIKit

enum RotationSource: Int {
    case drag
    case button
}

extension ViewController {

    //MARK: - Gesture Handling
    
    func addGestures() {
        disableRotationButtons()
        addDragGestures()
    }
    
    func disableRotationSource(source: RotationSource) {
        switch source {
        case .drag:
            disableDragGestures()
        case .button:
            disableRotationButtons()
        }
    }
    
    func enableRotationSource(source: RotationSource) {
        switch source {
        case .drag:
            enableDragGestures()
        case .button:
            enableRotationButtons()
        }
    }
    
    func disableRotation() {
        disableRotationSource(source:
            Defaults.get(key: Defaults.key_rotationSource) as! RotationSource)
    }

    func enableRotation() {
        enableRotationSource(source:
            Defaults.get(key: Defaults.key_rotationSource) as! RotationSource)
    }
    
    
    //MARK: - Buttons
    
    func showRotationButtons() {
        button_rotateCCW.isHidden = false
        button_rotateCW.isHidden = false
    }
    
    func hideRotationButtons() {
        button_rotateCCW.isHidden = true
        button_rotateCW.isHidden = true
    }
    
    func enableRotationButtons() {
        showRotationButtons()
        button_rotateCCW.isEnabled = true
        button_rotateCW.isEnabled = true
    }
    
    func disableRotationButtons() {
        hideRotationButtons()
        button_rotateCCW.isEnabled = false
        button_rotateCW.isEnabled = false
    }
    
    
    //MARK: - Drag Gesture
    
    func addDragGestures() {
        let swipeLeftGesture = UISwipeGestureRecognizer(
            target: self, action: #selector(handleDrag(gesture:)))
        let swipeRightGesture = UISwipeGestureRecognizer(
            target: self, action: #selector(handleDrag(gesture:)))
        let swipeUpGesture = UISwipeGestureRecognizer(
            target: self, action: #selector(handleDrag(gesture:)))
        let swipeDownGesture = UISwipeGestureRecognizer(
            target: self, action: #selector(handleDrag(gesture:)))
        swipeLeftGesture.direction = .left
        swipeRightGesture.direction = .right
        swipeUpGesture.direction = .up
        swipeDownGesture.direction = .down
        view_gesture.addGestureRecognizer(swipeLeftGesture)
        view_gesture.addGestureRecognizer(swipeRightGesture)
        view_gesture.addGestureRecognizer(swipeUpGesture)
        view_gesture.addGestureRecognizer(swipeDownGesture)
        dragGestures.append(swipeLeftGesture)
        dragGestures.append(swipeRightGesture)
        dragGestures.append(swipeUpGesture)
        dragGestures.append(swipeDownGesture)
        disableDragGestures()
    }
    
    @objc func handleDrag(gesture: UISwipeGestureRecognizer) {
        let boardCenter = view_board.frame.width / 2.0
        let boardInvalidZone = view_board.frame.width / 10.0
        let gestureLocation = gesture.location(ofTouch: 0, in: view_gesture)
        if (abs(gestureLocation.x - boardCenter) < boardInvalidZone
                && (gesture.direction == .up || gesture.direction == .down)) ||
            (abs(gestureLocation.y - boardCenter) < boardInvalidZone
                && (gesture.direction == .left || gesture.direction == .right)){
            return
        }
        switch gesture.direction {
        case .left:
            if boardCenter > gestureLocation.y {
                handleCCWRotation()
            } else {
                handleCWRotation()
            }
        case .right:
            if boardCenter > gestureLocation.y {
                handleCWRotation()
            } else {
                handleCCWRotation()
            }
        case .up:
            if boardCenter > gestureLocation.x {
                handleCWRotation()
            } else {
                handleCCWRotation()
            }
        case .down:
            if boardCenter > gestureLocation.x {
                handleCCWRotation()
            } else {
                handleCWRotation()
            }
        default:
            break
        }
    }
    
    func enableDragGestures() {
        for gestures in dragGestures {
            gestures.isEnabled = true
        }
    }
    
    func disableDragGestures() {
        for gestures in dragGestures {
            gestures.isEnabled = false
        }
    }
    
}
