//
//  SettingsTableExtension.swift
//  Tumble
//
//  Created by Daniel Kweon on 5/15/21.
//

import UIKit

let settingsCellIdentifier = "SettingsCell"

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTable() {
        table_settings.backgroundColor = .white
        table_settings.delegate = self
        table_settings.dataSource = self

        table_settings.register(SettingsCell.self, forCellReuseIdentifier: settingsCellIdentifier)
        table_settings.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let settings_section = SettingsSection(rawValue: section)
            else { return 0 }
        switch settings_section {
        case .Appearance:
            return AppearanceOptions.allCases.count
        case .RotationSource:
            return RotationSourceOptions.allCases.count
        case .Sound:
            return SoundOptions.allCases.count
        case .About:
            return AboutOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .gray
        title.text = SettingsSection(rawValue: section)?.description
        
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    settingsCellIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSection(rawValue: indexPath.section)
            else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        switch section {
        case .Appearance:
            cell.sectionType = AppearanceOptions(rawValue: indexPath.row)
        case .RotationSource:
            cell.sectionType = RotationSourceOptions(rawValue: indexPath.row)
        case .Sound:
            cell.sectionType = SoundOptions(rawValue: indexPath.row)
        case .About:
            cell.sectionType = AboutOptions(rawValue: indexPath.row)
            cell.selectionStyle = .default
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
