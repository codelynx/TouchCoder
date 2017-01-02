//
//	ViewController.swift
//	TouchCoder
//
//	Created by Kaz Yoshikawa on 1/2/17.
//	Copyright © 2017 Electricwoods LLC. All rights reserved.
//

import UIKit


class TouchViewController: UIViewController {

	@IBOutlet weak var touchView: TouchView!

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	@IBAction func erase(_ sender: UIBarButtonItem) {
		self.touchView.erase()
	}

	@IBAction func action(_ sender: UIBarButtonItem) {
		let codeString = self.touchView.codeString()
		let activityItems = [codeString]
		let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
		activityController.popoverPresentationController?.sourceView = self.view
		self.present(activityController, animated: true, completion: nil)
		print(codeString)
	}

}

