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
	let newContact = CNMutableContact()
	
	// MARK: Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setNewContact()
	}
	
	func setNewContact() {
		//fetchContactFromFireBase()
		// i'll get dict
		
		//newContact.givenName = ContactFromFireBase["name"]
		//newContact.phoneNumbers = [CNLabeledValue(label:CNLabelPhoneNumberiPhone, value:CNPhoneNumber(stringValue:ContactFromFireBase["number"]))]
		//let email = CNLabeledValue(label:CNLabelWork, value: ContatcFromFireBase["email"])
		//newContact.emailAddresses = [workEmail]
		
	}
	
	func saveNewContact() {
		let store = CNContactStore()
		let request = CNSaveRequest()
		request.add(newContact, toContainerWithIdentifier: nil)
		do {
			try store.execute(request)
		} catch let error{
			print("Error: \(error.localizedDescription)")
		}
	}
}
