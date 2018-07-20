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

		let middle = self.storyboard?.instantiateViewController(withIdentifier: "middle") as! CustomCameraViewController
		self.addChildViewController(middle)
		self.scroll.addSubview(middle.view)
		self.didMove(toParentViewController: self)

		var middleFrame: CGRect = middle.view.frame
		middleFrame.origin.x = self.view.frame.width
		middle.view.frame = middleFrame

		let right = self.storyboard?.instantiateViewController(withIdentifier: "right") as! LocationsViewController
		self.addChildViewController(right)
		self.scroll.addSubview(right.view)
		self.didMove(toParentViewController: self)

		var rightFrame: CGRect = right.view.frame
		rightFrame.origin.x = 2 * self.view.frame.width
		right.view.frame = rightFrame

		self.scroll.contentSize = CGSize(width: (self.view.frame.width) * 3, height: (self.view.frame.height))
		self.scroll.contentOffset = CGPoint(x: self.view.frame.width, y:0)
        
        self.dynamicButtonCreation()

	}

	@objc func scrollToContactCardView() {
        self.scroll.setContentOffset(CGPoint(x: 0, y:0), animated: true)

	}

	@objc func scrollToLocationsView() {
        self.scroll.setContentOffset(CGPoint(x: self.view.frame.width * 2, y:0), animated: true)
	}
    
    @objc func scrollCameraView() {
        self.scroll.setContentOffset(CGPoint(x: self.view.frame.width, y:0), animated: true)
    }
    
    func dynamicButtonCreation() {
        
        scroll.isScrollEnabled = true
        scroll.isUserInteractionEnabled = true
        
        //contactCardButton
        let contactCardButton = UIButton()
        contactCardButton.tag = 0
        contactCardButton.frame = CGRect(x: self.view.frame.width + 20, y: self.view.frame.height - 78, width: 55, height: 58)
        contactCardButton.setImage(#imageLiteral(resourceName: "personal-50"), for: .normal)
        contactCardButton.addTarget(self, action: #selector(scrollToContactCardView), for: .touchUpInside)
        scroll.addSubview(contactCardButton)
        
        //locationsButton
        let locationsButton = UIButton()
        locationsButton.tag = 1
        locationsButton.frame = CGRect(x: self.view.frame.width * 2 - 78, y: self.view.frame.height - 78, width: 55, height: 58)
        locationsButton.setImage(#imageLiteral(resourceName: "contacts-50"), for: .normal)
        locationsButton.addTarget(self, action: #selector(scrollToLocationsView), for: .touchUpInside)
        scroll.addSubview(locationsButton)
        
        //BackButtonFromLocations
        let locationsBackButton = UIButton()
        locationsBackButton.tag = 1
        locationsBackButton.frame = CGRect(x: self.view.frame.width * 2 + 10, y: 30, width: 55, height: 30)
        locationsBackButton.setTitle("<Back", for: .normal)
        locationsBackButton.setTitleColor(UIColor(displayP3Red: 0.94, green: 0.6, blue: 0.21, alpha: 1), for: .normal)
        locationsBackButton.addTarget(self, action: #selector(scrollCameraView), for: .touchUpInside)
        scroll.addSubview(locationsBackButton)
    }
    
}
