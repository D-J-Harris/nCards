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
    @IBOutlet weak var emailTextLabel: UILabel!
    @IBOutlet weak var phoneTextField: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    let firUser = Auth.auth().currentUser

    override func viewDidLoad() {
		super.viewDidLoad()
        cardView.layer.cornerRadius = 8.0
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.6
        cardView.layer.shadowOffset = CGSize(width: -15, height: 20)
        cardView.clipsToBounds = true
        

        let ref = Database.database().reference().child("users").child((firUser?.uid)!)

        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value)
            let contactAttrs = snapshot.value as? [String: Any]
            self.phoneTextField.text = contactAttrs?["phone"] as! String
        })

        nameTextLabel.text = firUser?.displayName
        emailTextLabel.text = firUser?.email

    }
}
