//
//  ContactCardViewController.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseUI

class ContactCardViewController: UIViewController {
	
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var currentPositionTextLabel: UILabel!
    @IBOutlet weak var organizationTextLabel: UILabel!
    @IBOutlet weak var emailTextLabel: UILabel!
    @IBOutlet weak var phoneTextField: UILabel!
    
    let firUser = Auth.auth().currentUser
    
    override func viewDidLoad() {
		super.viewDidLoad()
        
        let ref = Database.database().reference().child("users").child((firUser?.uid)!)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            let contactAttrs = snapshot.value as? [String: Any]
            self.currentPositionTextLabel.text = contactAttrs?["currentPosition"] as! String
            self.organizationTextLabel.text = contactAttrs?["company"] as! String
            self.phoneTextField.text = contactAttrs?["phone"] as! String
        })
        
        nameTextLabel.text = firUser?.displayName
        emailTextLabel.text = firUser?.email
        
    }
}
