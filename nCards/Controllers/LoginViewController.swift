//
//  LoginViewController.swift
//  nCards
//
//  Created by Ricardo Ramirez on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        print("tap")
        
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
        
    }
}
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            print("ERROR WEIRD")
            return
        }
        
        guard let user = user
            else { return }
        
//        let userRef = Database.database().reference().child("users").child(user.uid)
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                
                Contact.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                
            } else {
                // handle new user
                self.performSegue(withIdentifier: "toContactFill", sender: self)
            }
        }
    }
}
