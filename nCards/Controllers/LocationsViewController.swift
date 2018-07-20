//
//  LocationsViewController.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LocationsViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AddService.getAllContacts(user: Contact.current) { (contacts) in
            self.contacts = contacts
            self.tableView.reloadData()
        }
    }
}
extension LocationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCellTableViewCell", for: indexPath) as! ContactCellViewController
        cell.nameTextLabel.text = contacts[indexPath.row].name
        cell.emailTextLabel.text = contacts[indexPath.row].email
        cell.phoneTextLabel.text = contacts[indexPath.row].phone
        
        cell.imageIcon.image = UIImage(named: "animal\(arc4random_uniform(15) + 1)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
