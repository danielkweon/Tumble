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
    case appearance
    case rotationSource
    case sound
    case about

    var description: String {
        switch self {
        case .appearance:
            return "Appearance"
        case .rotationSource:
            return "Rotation Source"
        case .sound:
            return "Sound"
        case .about:
            return "About"
        }
    }

}

enum AppearanceOptions: Int,
                        CaseIterable,
                        SectionType {
    case darkMode
    case automatic

    var containsSwitch: Bool {
        switch self {
        case .darkMode:
            return true
        case .automatic:
            return true
        }
    }

    var description: String {
        switch self {
        case .darkMode:
            return "Dark Mode"
        case .automatic:
            return "Automatic Mode"
        }
    }

}

enum RotationSourceOptions: Int,
                        CaseIterable,
                        SectionType {
    case swipe
    case button

    var containsSwitch: Bool { return true }

    var description: String {
        switch self {
        case .swipe:
            return "Swipe"
        case .button:
            return "Button"
        }
    }

}

enum SoundOptions: Int,
                        CaseIterable,
                        SectionType {
    case sound

    var containsSwitch: Bool { return true }

    var description: String {
        switch self {
        case .sound:
            return "Sound"
        }
    }

}

enum AboutOptions: Int,
                        CaseIterable,
                        SectionType {
    case tutorial
    case privacy

    var containsSwitch: Bool { return false }

    var description: String {
        switch self {
        case .tutorial:
            return "Tutorial"
        case .privacy:
            return "Privacy"
        }
    }

}
