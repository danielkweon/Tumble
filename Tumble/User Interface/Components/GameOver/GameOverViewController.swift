//
//  GameOverViewController.swift
//  Tumble
//
//  Created by Daniel Kweon on 9/9/21.
//

import UIKit

class GameOverViewController: UIViewController {

    //MARK: - User Interface Components
    
    @IBOutlet weak var button_tryAgain: UIButton!
    
    
    //MARK: - Variables
    
    var completionHandler               : (() -> Void)?
    var tryAgainHandler                 : (() -> Void)?

    
    //MARK: - Set up

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGameOverView()
    }
    
    func prepareGameOverView() {
        button_tryAgain.layoutIfNeeded()
        button_tryAgain.layer.cornerRadius = button_tryAgain.frame.height / 8.0
    }
    
    
    //MARK: - Button Actions

    @IBAction func tryAgainButtonPressed(_ sender: UIButton) {
        tryAgainHandler!()
        dismiss(animated: false, completion: completionHandler)
    }
    
    
}

