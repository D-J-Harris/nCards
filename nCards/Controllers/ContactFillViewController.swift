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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        guard let firUser = Auth.auth().currentUser,
            let phone = phoneNumberTextField.text,
            !phone.isEmpty else { return }
        let company = companyTextField.text
        
        UserService.create(firUser, phoneNumber: phone, company: company!) { (user) in
            guard let user = user else { return }
            
            Contact.setCurrent(user, writeToUserDefaults: true)
            }
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main) //change this back
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        } else {
            print("not happening")
        }
    }
}

