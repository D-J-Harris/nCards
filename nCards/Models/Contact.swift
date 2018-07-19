//
//  Contact.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class Contact: Codable {
    
    var name: String = ""
    var uid: String = ""
    var email: String = ""
    var phone: String = ""
    var username: String = ""
    
    init(uid: String, username: String, name: String, email: String, phone: String) {
        
        self.name = name
        self.email = email
        self.phone = phone
        self.username = username
        self.uid = uid
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
        let username = dict["uid"] as? String
        else { return nil }
        self.uid = snapshot.key
        self.username = username
    }
    
    private static var _current: Contact?
    
    static var current: Contact {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
 
        return currentUser
    }
    
    
    static func setCurrent(_ user: Contact, writeToUserDefaults: Bool = false) {

        if writeToUserDefaults {

            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: "currentUser")
            }
        }
        
        _current = user
    }
}
