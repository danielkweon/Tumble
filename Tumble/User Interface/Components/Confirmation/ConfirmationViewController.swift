//
//  ConfirmationViewController.swift
//  Tumble
//
//  Created by Daniel Kweon on 9/11/21.
//

import UIKit

class ConfirmationViewController: UIViewController {

    //MARK: - User Interface Components
    
    @IBOutlet weak var view_confirmation    : UIView!
    @IBOutlet weak var label_confirmation   : UILabel!
    @IBOutlet weak var button_cancel        : UIButton!
    @IBOutlet weak var button_confirm       : UIButton!
    
    
    //MARK: - Variables
    
    var confirmationText                : String?
    var confirmButtonText               : String?
    var completionHandler               : (() -> Void)?
    var confirmHandler                  : (() -> Void)?

    
    //MARK: - Set up

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareConfirmationView()
    }
    
    func prepareConfirmationView() {
        view_confirmation.layoutIfNeeded()
        button_cancel.layoutIfNeeded()
        button_confirm.layoutIfNeeded()

        label_confirmation.text = confirmationText
        button_confirm.setTitle(confirmButtonText, for: .normal)
        button_cancel.layer.cornerRadius = button_cancel.frame.height / 8.0
        button_confirm.layer.cornerRadius = button_confirm.frame.height / 8.0
        view_confirmation.layer.cornerRadius = view_confirmation.frame.width / 30.0
    }
    
    
    //MARK: - Button Actions
    
    func _completionHandler() {
        dismiss(animated: true, completion: completionHandler)
    }

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        _completionHandler()
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        confirmHandler!()
        _completionHandler()
    }
    
}

