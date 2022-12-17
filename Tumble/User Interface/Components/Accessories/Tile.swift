//
//  Tile.swift
//  Tumble
//
//  Created by Daniel Kweon on 4/21/21.
//

import UIKit

class Tile: UIView {
    
    var label: UILabel = UILabel()
    var value: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = layer.frame.width / 10.0
        let label_width = frame.width * 5.0 / 6.0
        let label_margin = frame.width * 1.0 / 12.0
        label = UILabel(frame: CGRect(origin: CGPoint(x: label_margin, y: 0),
                                      size: CGSize(width: label_width, height: frame.height)))
        label.textAlignment = .center
        addSubview(label)
        setHidden()
    }
    
    func setHidden() {
        label.text = ""
        value = 0
        alpha = 0.0
    }
    
    func setActive(value: Int, colorDefault: ColorDefaults) {
        self.value = value
        let (lColor, bColor) = Colors.colorFor(value: value, colorDefault: colorDefault)
        backgroundColor = bColor
        alpha = 1.0
        
        label.text = String(value)
        label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 2.0 / 3.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.baselineAdjustment = .alignCenters
        label.textColor = lColor
        
        //        switch label.text!.count {
        //        case 1:
        //            label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 0.666)
        //        case 2:
        //            label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 0.600)
        //        case 3:
        //            label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 0.450)
        //        case 4:
        //            label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 0.400)
        //        case 5:
        //            label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 0.325)
        //        case 6:
        //            label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 0.275)
        //        case 7:
        //            label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 0.235)
        //        default:
        //            label.font = UIFont(name: "Helvetica-Bold", size: frame.height * 0.210)
        //        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
