//
//  Colors.swift
//  Tumble
//
//  Created by Daniel Kweon on 1/25/21.
//

import UIKit

struct RGB {
    let R: Int
    let G: Int
    let B: Int
}

enum ColorDefaults: Int,
                    CaseIterable,
                    CustomStringConvertible
{
    case blue
    case red
    case green
    case yellow
    case pink
    case purple
//    case gray
//    case brown
//
//    case floral
//    case pastel
//    case beach
//    case aurora
//    case galaxy
//    case forest
//    case sunset
//    case summer
//    case funky

    var description: String {
        switch self {
        case .blue:
            return "Blue"
        case .red:
            return "Red"
        case .green:
            return "Green"
        case .yellow:
            return "Yellow"
        case .pink:
            return "Pink"
        case .purple:
            return "Purple"
        }
    }
}

class Colors {
    
    static let blackRGB = RGB(R: 0, G: 0, B: 0)
    static let whiteRGB = RGB(R: 255, G: 255, B: 255)

    static func colorFor(value: Int, colorDefault: ColorDefaults) -> (UIColor, UIColor) {
        let index = Int(log2(CGFloat(value))) - 1
        var bRGB: RGB = RGB(R: 0, G: 0, B: 0)
        var lRGB: RGB = RGB(R: 0, G: 0, B: 0)

        switch colorDefault {
        case .blue:
            (bRGB, lRGB) = index < blueColors.count ?
                blueColors[index] : (RGB(R: 0, G: 0, B: 255), whiteRGB)
        case .red:
            (bRGB, lRGB) = index < redColors.count ?
                redColors[index] : (RGB(R: 255, G: 0, B: 0), whiteRGB)
        case .green:
            (bRGB, lRGB) = index < blueColors.count ?
                greenColors[index] : (RGB(R: 0, G: 255, B: 0), whiteRGB)
        case .yellow:
            (bRGB, lRGB) = index < redColors.count ?
                yellowColors[index] : (RGB(R: 255, G: 255, B: 0), whiteRGB)
        case .pink:
            (bRGB, lRGB) = index < blueColors.count ?
                pinkColors[index] : (RGB(R: 255, G: 192, B: 203), whiteRGB)
        case .purple:
            (bRGB, lRGB) = index < redColors.count ?
                purpleColors[index] : (RGB(R: 147, G: 112, B: 219), whiteRGB)
        }
        let backColor = UIColor(displayP3Red:   CGFloat(bRGB.R)/255,
                                green:          CGFloat(bRGB.G)/255,
                                blue:           CGFloat(bRGB.B)/255,
                                alpha:          1.0)
        let labelColor = UIColor(displayP3Red:  CGFloat(lRGB.R)/255,
                                 green:         CGFloat(lRGB.G)/255,
                                 blue:          CGFloat(lRGB.B)/255,
                                 alpha:         1.0)
        return (labelColor, backColor)
    }
    
    static let blueColors: [(RGB, RGB)] = [
        (RGB(R: 175, G: 225, B: 255),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 150, G: 195, B: 250),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 135, G: 175, B: 195),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 80,  G: 155, B: 255),       RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 65,  G: 200, B: 220),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 20,  G: 180, B: 240),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 115, G: 135, B: 185),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 10,  G: 150, B: 190),       RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 60,  G: 100, B: 140),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 30,  G: 100, B: 200),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 15,  G: 40,  B: 230),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 0,   G: 60,  B: 150),       RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 30,  G: 45,  B: 100),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 0,   G: 0,   B: 80),        RGB(R: 255, G: 255, B: 255)),
        ]
    
    static let redColors: [(RGB, RGB)] = [
        (RGB(R: 250, G: 130, B: 115),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 205, G: 95,  B: 95),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 235, G: 60,  B: 85),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 240, G: 40,  B: 60),        RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 180, G: 55,  B: 90),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 210, G: 30,  B: 60),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 180, G: 35,  B: 35),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 190, G: 10,  B: 48),        RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 185, G: 15,  B: 10),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 140, G: 5,   B: 30),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 125, G: 10,  B: 5),         RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 160, G: 60,  B: 25),        RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 95,  G: 25,  B: 20),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 80,  G: 0,   B: 0),         RGB(R: 255, G: 255, B: 255)),
        ]

    static let greenColors: [(RGB, RGB)] = [
        (RGB(R: 208, G: 240, B: 192),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 152, G: 251, B: 152),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 80,  G: 220, B: 100),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 76,  G: 187,  B: 23),       RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 57,  G: 255, B: 20),        RGB(R: 255, G: 255, B: 255)),
        ]

    static let yellowColors: [(RGB, RGB)] = [
        (RGB(R: 252, G: 244, B: 163),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 255, G: 211, B: 0),         RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 255, G: 195, B: 11),        RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 218, G: 165, B: 32),        RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 249, G: 166,  B: 2),        RGB(R: 255, G: 255, B: 255)),
        ]

    static let pinkColors: [(RGB, RGB)] = [
        (RGB(R: 255, G: 105, B: 180),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 251, G: 174, B: 210),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 254, G: 127, B: 156),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 255, G: 102, B: 204),       RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 254, G: 127, B: 156),       RGB(R: 255, G: 255, B: 255)),
        ]

    static let purpleColors: [(RGB, RGB)] = [
        (RGB(R: 230, G: 230, B: 250),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 216, G: 191, B: 216),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 221, G: 160, B: 221),       RGB(R: 255, G: 255, B: 255)),
        (RGB(R: 238, G: 130, B: 238),       RGB(R: 255, G: 255, B: 255)),
        
        (RGB(R: 186, G: 85,  B: 211),       RGB(R: 255, G: 255, B: 255)),
        ]

}
