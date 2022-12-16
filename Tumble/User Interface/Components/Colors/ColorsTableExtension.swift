//
//  ColorsTableExtension.swift
//  Tumble
//
//  Created by Daniel Kweon on 12/15/22.
//

import UIKit

let colorsTableViewCellIdentifier = "ColorsTableViewCell"

extension ColorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTable() {
        table_colors.backgroundColor = .clear
        table_colors.delegate = self
        table_colors.dataSource = self

        table_colors.register(ColorsTableViewCell.nib,
                             forCellReuseIdentifier: colorsTableViewCellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return table_colors.frame.height / 4.5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ColorDefaults.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: colorsTableViewCellIdentifier,
                                                 for: indexPath) as! ColorsTableViewCell
        cell.color = ColorDefaults(rawValue: indexPath.row)
        cell.delegate = self
        return cell
    }
    
}
