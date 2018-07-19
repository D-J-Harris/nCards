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
    var organization: String = ""
    var phone: String = ""
    var address: String = ""
    var geoLocation: Int = 0
    var username: String = ""
    var currentPosition: String = ""
    
    init(uid: String, username: String, name: String, email: String, organization: String, phone: String, address: String, geoLocation: Int, currentPosition: String) {
        
        self.name = name
        self.email = email
        self.organization = organization
        self.phone = phone
        self.address = phone
        self.geoLocation = geoLocation
        self.username = username
        self.uid = uid
        self.currentPosition = currentPosition
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
