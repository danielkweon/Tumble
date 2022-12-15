//
//  GridsTableExtension.swift
//  Tumble
//
//  Created by Daniel Kweon on 12/12/22.
//

import UIKit

let gridsTableViewCellIdentifier = "GridsTableViewCell"

extension GridsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTable() {
        table_grids.backgroundColor = .clear
        table_grids.delegate = self
        table_grids.dataSource = self

        table_grids.register(GridsTableViewCell.nib,
                             forCellReuseIdentifier: gridsTableViewCellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return table_grids.frame.height / 3.75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GridDefaults.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: gridsTableViewCellIdentifier,
                                                 for: indexPath) as! GridsTableViewCell
        cell.grid = GridDefaults(rawValue: indexPath.row)
        cell.delegate = self
        return cell
    }
    
}
