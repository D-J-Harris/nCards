//
//  ContactAddEditViewController.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/19/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import Foundation
import Contacts
import FirebaseDatabase

class ContactAddEditViewController: UIViewController {

	// MARK: Properties
    var newContactCreated = Contact(uid: "", username: "", name: "", email: "", phone: "")
	let newContact = CNMutableContact()
	//let contactToSave: [String:String] = [:]
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var phoneNumberTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!

	// MARK: Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		//Looks for single or multiple taps.
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
		//Uncomment the line below if you want the tap not not interfere and cancel other interactions.
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)

		nameTextField.text = newContactCreated.name
		phoneNumberTextField.text = newContactCreated.phone
		emailTextField.text = newContactCreated.email
	}

	//Calls this function when the tap is recognized.
	@objc func dismissKeyboard() {
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
	}

	func setNewContact() {
		newContact.givenName = nameTextField.text!
		newContact.phoneNumbers = [CNLabeledValue(label:CNLabelPhoneNumberiPhone, value:CNPhoneNumber(stringValue:phoneNumberTextField.text!))]
		newContact.emailAddresses = [CNLabeledValue(label:CNLabelWork, value:emailTextField.text! as NSString)]
	}

	func saveNewContact() {
		setNewContact()
		AddService.updateContact(newContactCreated, name: nameTextField.text!, phone: phoneNumberTextField.text!, email: emailTextField.text!)
		let store = CNContactStore()
		let request = CNSaveRequest()
		request.add(newContact, toContainerWithIdentifier: nil)
		do {
			try store.execute(request)
		} catch let error{
			print("Error: \(error.localizedDescription)")
		}
		print("saved new contact!")
	}
    
    func deleteContact(_ contact: Contact) {
        let ref = Database.database().reference().child("users/\(Contact.current.uid)/contacts/\(contact.uid)")
        ref.removeValue { (error, _) in
            if let error = error {
                print(error)
            }
        }
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let identifier = segue.identifier else { return }

		switch identifier {
		case "cancel":
            deleteContact(newContactCreated)
			print("cancel save tapped")
		case "saveToContacts":
			saveNewContact()
			print("saveToContacts tapped")
		default:
			print("unexpected segue identifier")
		}
	}
}
