//
//  SettingsCell.swift
//  Tumble
//
//  Created by Daniel Kweon on 5/24/21.
//

import UIKit

class SettingsCell: UITableViewCell {

    // MARK: - Properties

    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = false
        switchControl.onTintColor = UIColor.red
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        return switchControl
    }()

    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else {return}
            textLabel?.text = sectionType.description
            textLabel?.textColor = .darkGray
            switchControl.isHidden = !sectionType.containsSwitch
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: settingsCellIdentifier)
        backgroundColor = .clear

        contentView.addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("is On")
        } else {
            print("is Off")
        }
    }

}
