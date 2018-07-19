//
//  LocationsViewController.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class LocationsViewControllers: UIViewController {
	
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
		super.viewDidLoad()
        
//        navigationItem.title = "Scanned Contacts"
//        navigationController?.navigationBar.prefersLargeTitles = true
	}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCellTableViewCell", for: indexPath) as! ContactCellTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

}
