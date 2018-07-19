//
//  ContainerViewController.swift
//  nCards
//
//  Created by Juan Pablo Ramos on 7/17/18.
//  Copyright © 2018 Juan Pablo Ramos. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

	// MARK: Properties
	
	@IBOutlet weak var scroll: UIScrollView!
	
	
	// MARK: Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scroll.showsHorizontalScrollIndicator = false
		
		let left = self.storyboard?.instantiateViewController(withIdentifier: "left") as! ContactCardViewController
		self.addChildViewController(left)
		self.scroll.addSubview(left.view)
		self.didMove(toParentViewController: self)
		left.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
		left.view.leadingAnchor.constraint(equalTo: scroll.layoutMarginsGuide.leadingAnchor)
		left.view.trailingAnchor.constraint(equalTo: scroll.layoutMarginsGuide.trailingAnchor)
		left.view.topAnchor.constraint(equalTo: scroll.layoutMarginsGuide.topAnchor)
		left.view.bottomAnchor.constraint(equalTo: scroll.layoutMarginsGuide.bottomAnchor)
		
		// swift programmatically constraints for each view
		
		let middle = self.storyboard?.instantiateViewController(withIdentifier: "middle") as! CustomCameraViewController
		self.addChildViewController(middle)
		self.scroll.addSubview(middle.view)
		self.didMove(toParentViewController: self)
		
		var middleFrame: CGRect = middle.view.frame
		middleFrame.origin.x = self.view.frame.width
		middle.view.frame = middleFrame
		
		let right = self.storyboard?.instantiateViewController(withIdentifier: "right") as! LocationsViewControllers
		self.addChildViewController(right)
		self.scroll.addSubview(right.view)
		self.didMove(toParentViewController: self)
		
		var rightFrame: CGRect = right.view.frame
		rightFrame.origin.x = 2 * self.view.frame.width
		right.view.frame = rightFrame
		
		self.scroll.contentSize = CGSize(width: (self.view.frame.width) * 3, height: (self.view.frame.height))
		self.scroll.contentOffset = CGPoint(x: self.view.frame.width, y:0)
		
	}
	
	static func scrollToContactCardView() {
		//self.scroll.contentOffset = CGPoint(x: 0, y:0)
		print("container recieved contact card tap")

	}
	
	static func scrollToLocationsView() {
		//self.scroll.contentOffset = CGPoint(x: self.view.frame.width * 2, y:0)
		print("container recieved locations tap")
	}
}
