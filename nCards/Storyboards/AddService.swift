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
	
	static func updateContact(_ currentContact: Contact, name: String, phone: String, email: String) {
		let currentUID = Contact.current.uid
		
		let ref = Database.database().reference().child("users").child(currentUID).child("contacts").child(currentContact.uid)
		
		let userCardInfo = ["phone": phone,
							"email": email,
							"name": name]
		
		ref.updateChildValues(userCardInfo) { (error, ref) in
			if let error = error {
				assertionFailure(error.localizedDescription)
				return
			}
		}
		
	}
    
    static func getAllContacts(user currentUser: Contact, completion: @escaping ([Contact]) -> Void) {
        var contactsArray: [Contact] = []
        let currentUID = currentUser.uid
        
        let ref = Database.database().reference().child("users").child(currentUID).child("contacts")
        print(ref)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.children)
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                if let contactInfo = snap.value as? [String:String] {
                    let fetchedContact =  Contact(uid: "", username: "", name: contactInfo["name"]!, email: contactInfo["email"]! , phone: contactInfo["phone"]!)
                    contactsArray.append(fetchedContact)
                }
            }
            if contactsArray.count > 0 {
                completion(contactsArray)
            } else {
                completion([])
            }
        })        
    }
}











