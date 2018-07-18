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
    
    init(uid: String, username: String, name: String, email: String, organization: String, phone: String, address: String, geoLocation: Int) {
        
        self.name = name
        self.email = email
        self.organization = organization
        self.phone = phone
        self.address = phone
        self.geoLocation = geoLocation
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
    
    
    // MARK: - Singleton
    
    // 1
    private static var _current: Contact?
    
    // 2
    static var current: Contact {
        // 3
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        // 4
        return currentUser
    }
    
    // 1
    static func setCurrent(_ user: Contact, writeToUserDefaults: Bool = false) {
        // 2
        if writeToUserDefaults {
            // 3
            if let data = try? JSONEncoder().encode(user) {
                // 4
                UserDefaults.standard.set(data, forKey: "currentUser")
            }
        }
        
        _current = user
    }
}
