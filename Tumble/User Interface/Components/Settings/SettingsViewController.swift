//
//  SettingsViewController.swift
//  Tumble
//
//  Created by Daniel Kweon on 5/13/21.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK: - User Interface Components
    
    @IBOutlet weak var table_settings: UITableView!
    
    
    //MARK: - Variables
        
    
    //MARK: - Set up

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpTable()
    }
    
}

