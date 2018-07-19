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
    @IBOutlet weak var cardView1: UIView!
    @IBOutlet weak var cardView: UIView!
    
    let firUser = Auth.auth().currentUser

    override func viewDidLoad() {
		super.viewDidLoad()
        cardView1.layer.cornerRadius = 8.0
        cardView1.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = CGSize(width: -10, height: 10)
        cardView1.clipsToBounds = true
        

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
