//
//  ContactFillViewController.swift
//  nCards
//
//  Created by Ricardo Ramirez on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class ContactFillViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var currentPositionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        guard let firUser = Auth.auth().currentUser,
            let phone = phoneNumberTextField.text,
            !phone.isEmpty else { return }
        let company = companyTextField.text
        let currentPosition = currentPositionTextField.text
        
        UserService.create(firUser, phoneNumber: phone, company: company!, currentPosition: currentPosition!) { (user) in
            guard let user = user else { return }
            
            Contact.setCurrent(user)
            }
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        } else {
            print("not happening")
        }
    }
    
    
}
