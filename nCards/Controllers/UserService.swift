//
//  UserService.swift
//  nCards
//
//  Created by Ricardo Ramirez on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    //READ
    static func show(forUID uid: String, completion: @escaping (Contact?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = Contact(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(user)
        })
    }
    //CREATE
    static func create(_ firUser: FIRUser, phoneNumber: String, company: String, completion: @escaping (Contact?) -> Void) {
        let userCardInfo = ["phone": phoneNumber,
                        "company": company,
                        "uid": firUser.uid,
                        "contacts": "No contacts yet"] //added this reference
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        //Save
        ref.setValue(userCardInfo) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = Contact(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    //function to display alerts
    static func showAlert(on: UIViewController, style: UIAlertControllerStyle, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .default, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        on.present(alert, animated: true, completion: completion)
    }
    
}
