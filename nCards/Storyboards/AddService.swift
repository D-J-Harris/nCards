//
//  AddService.swift
//  nCards
//
//  Created by Daniel Harris on 19/07/2018.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct AddService {
    
    static func addContact(_ contact: Contact) {
        let currentUID = Contact.current.uid
        
        let userCardInfo = ["phone": contact.phone,
                            "email": contact.email,
                            "name": contact.name]
        let ref = Database.database().reference().child("users").child(currentUID).child("contacts").child(contact.uid) //better way than random string?
        
        //if user there, alert user exists //extension very hard as we can't tell without looping over current users

        ref.updateChildValues(userCardInfo) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
        }
    }
    
    static func fetchContact(_ currentContact: Contact, contactDBID IDReference: String) -> [String: Any] {
        var output = [String:String]() //empty dictionary for contactInfo
        
        let currentUID = currentContact.uid
        let ref = Database.database().reference().child("users/\(currentUID)/contacts/\(IDReference)")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let infoDict = snapshot.value as? [String:String]
                else {
                    return
            }
            output = infoDict
        })
        print("infoDict======\(output)")
        return output
    }
}
