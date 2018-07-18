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
    static func create(_ firUser: FIRUser, phoneNumber: String, company: String, currentPosition: String ,completion: @escaping (Contact?) -> Void) {
        let userCardInfo = ["phone": phoneNumber,
                        "company": company,
                        "currentPosition": currentPosition,
                        "uid": firUser.uid]
        
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
}
