//
//  GridsViewController.swift
//  Tumble
//
//  Created by Daniel Kweon on 12/12/22.
//

import UIKit

class GridsViewController: UIViewController {

    //MARK: - User Interface Components
    
    @IBOutlet weak var table_grids: UITableView!
    
    
    //MARK: - Variables
    
    var completionHandler  : (() -> Void) = {}

    
    //MARK: - Set up

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completionHandler()
    }
    
}
