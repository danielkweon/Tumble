//
//  SettingsEnums.swift
//  Tumble
//
//  Created by Daniel Kweon on 5/29/21.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int,
                      CaseIterable,
                      CustomStringConvertible {
    case Appearance
    case RotationSource
    case Sound
    case About
    
    var description: String {
        switch self {
        case .Appearance:
            return "Appearance"
        case .RotationSource:
            return "Rotation Source"
        case .Sound:
            return "Sound"
        case .About:
            return "About"
        }
    }
}

enum AppearanceOptions: Int,
                        CaseIterable,
                        SectionType {
    case DarkMode
    case Automatic
    
    var containsSwitch: Bool {
        switch self {
        case .DarkMode:
            return true
        case .Automatic:
            return true
        }
    }
    
    var description: String {
        switch self {
        case .DarkMode:
            return "Dark Mode"
        case .Automatic:
            return "Automatic Mode"
        }
    }
}

enum RotationSourceOptions: Int,
                        CaseIterable,
                        SectionType {
    case Swipe
    case Button
    
    var containsSwitch: Bool { return true }
    
    var description: String {
        switch self {
        case .Swipe:
            return "Swipe"
        case .Button:
            return "Button"
        }
    }
}

enum SoundOptions: Int,
                        CaseIterable,
                        SectionType {
    case Sound
    
    var containsSwitch: Bool { return true }
    
    var description: String {
        switch self {
        case .Sound:
            return "Sound"
        }
    }
}

enum AboutOptions: Int,
                        CaseIterable,
                        SectionType {
    case Tutorial
    case Privacy
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .Tutorial:
            return "Tutorial"
        case .Privacy:
            return "Privacy"
        }
    }
}
