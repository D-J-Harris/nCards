//
//  ContactAddEditViewController.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/19/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactAddEditViewController: CNContactViewController {
	
	// MARK: Properties
    var newContactCreated = Contact(uid: "", username: "", name: "", email: "", phone: "")
	let newContact = CNMutableContact()
	
	// MARK: Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setNewContact()
	}
	
	func setNewContact() {
		//fetchContactFromFireBase()
		// i'll get dict
		
		//newContact.givenName = newContactCreated.name
		//newContact.phoneNumbers = [CNLabeledValue(label:CNLabelPhoneNumberiPhone, value:CNPhoneNumber(stringValue:ContactFromFireBase["number"]))]
		//let email = CNLabeledValue(label:CNLabelWork, value: ContatcFromFireBase["email"])
		//newContact.emailAddresses = [workEmail]
		
	}
	
	func saveNewContact() {
		let store = CNContactStore()
		let saveRequest = CNSaveRequest()
		saveRequest.add(newContact, toContainerWithIdentifier: nil)
		try! store.execute(saveRequest)
	}
}
