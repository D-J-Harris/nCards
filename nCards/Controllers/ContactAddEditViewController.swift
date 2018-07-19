//
//  ContactAddEditViewController.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/19/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import Contacts

class ContactAddEditViewController: UIViewController {
	
	// MARK: Properties
	let newContact = CNMutableContact()
	//let contactToSave: [String:String] = [:]
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var phoneNumberTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	
	// MARK: Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setNewContact()
		//Looks for single or multiple taps.
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
		
		//Uncomment the line below if you want the tap not not interfere and cancel other interactions.
		tap.cancelsTouchesInView = false
		
		view.addGestureRecognizer(tap)
		nameTextField.text = "John Doe"
		phoneNumberTextField.text = "(43) 7568-3455"
		emailTextField.text = "john.doe@company.com"
	}
	
	//Calls this function when the tap is recognized.
	@objc func dismissKeyboard() {
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
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
//		let store = CNContactStore()
//		let request = CNSaveRequest()
//		request.add(newContact, toContainerWithIdentifier: nil)
//		do {
//			try store.execute(request)
//		} catch let error{
//			print("Error: \(error.localizedDescription)")
//		}
		print("saved new contact!")
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let identifier = segue.identifier else { return }
		
		switch identifier {
		case "cancel":
			print("cancel save tapped")
		case "saveToContacts":
			saveNewContact()
			print("saveToContacts tapped")
		default:
			print("unexpected segue identifier")
		}
	}
}










