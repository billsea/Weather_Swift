//
//  ViewController.swift
//  TableViewProject_Swift
//
//  Created by Loud on 1/11/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
	@IBOutlet weak var ShowTableButton: UIButton!
	

	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
	}
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	//MARK: actions
	@IBAction func ShowTable(_ sender: Any) {
		let r = ResultsTableViewController()

		//the callback function
		r.callback = {(_ num: Int) -> Void in
			//print selected row index from table view
			print(num)
		
		}
		
		show(r, sender: self)

	}

}

