//
//  Defaults.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import Foundation

class Defaults {
    
    //MARK: - Default Values
    
    static let default_board                    = "4x4"
    static let default_currentScore             = 0
    static let default_bestScores               = ["4x4"    : 0,
                                                   "4x4_1"  : 0,
                                                   "5x5"    : 0,
                                                   "5x5_1"  : 0,
                                                   "5x5_2"  : 0]

    
    //MARK: - User Defaults Keys
    
    static let key_darkAppearance               = "default_dark_appearance"
    static let key_unlockedColors               = "default_unlocked_colors"
    static let key_color                        = "default_color"
        
    static let key_board                        = "default_board"
    static let key_score                        = "default_score"
    static let key_bestScores                   = "default_best_score"
    static let key_bestBoards                   = "default_best_boards"
    static let key_rotationSource               = "default_rotation_source"

    
    //MARK: - Get and Set
    
    static func get(key: String) -> Any? {
        if UserDefaults.standard.object(forKey: key) == nil {
            print("\(key) not found")
            switch key {
            case key_board:
                set(key: key, value: default_board)
            case key_color:
                set(key: key, value: ColorDefaults.blue.rawValue)
            case key_rotationSource:
                set(key: key, value: RotationSource.drag.rawValue)
            case key_score:
                set(key: key, value: default_currentScore)
            case key_bestScores:
                set(key: key, value: default_bestScores)
            default:
                break
            }
        }
        switch key {
        case key_color:
            return ColorDefaults(
                rawValue: UserDefaults.standard.object(forKey: key) as! Int)
        case key_rotationSource:
            set(key: key, value: RotationSource.drag.rawValue)
            return RotationSource(
                rawValue: UserDefaults.standard.object(forKey: key) as! Int)
        default:
            return UserDefaults.standard.object(forKey: key)
        }
    }
    
    static func set(key: String, value: Any) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
}
