//
//  ViewController.swift
//  TableViewProject_Swift
//
//  Created by Loud on 1/11/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

import UIKit

class ViewControllerStart: UIViewController, update_delegate {
	@IBOutlet weak var ShowTableButton: UIButton!
	
	//Closure examples:
	var theMostBasicClosure = { () -> () in
		print("A basic closure example")
	}
	
	//closure with parameter
	var paramClosure = { (val: Float) -> () in
		print(val)
	}
	
	//closure with parameter and return value
	var paramClosureReturnVal = { (val: Int) -> Int in
		print(val)
		return val
	}
	
	//MARK: delegate methods
	func name_update(label: String) {
		print(label)
	}
	
	//Closure method examples:
	
	//basic closure
	func operationsSq(a: Int, b:Int, myFunction: (Int, Int)->Int)->Int
	{
		return myFunction(a,b)
	}
	
	func addSquareFunc(_ a: Int, _ b:Int)->Int
	{
		return a*a + b*b
	}
	
	//example 2
	func combineArrays(_ array1: [Int],
										 _ array2: [Int],
										 _ closure: (Int,Int) -> Int) -> [Int] {
		var result: [Int] = []
		for i in 0..<array1.count {
			result.append(closure(array1[i],array2[i]))
		}
		return result
	}
	
	func testArrays() {
			let array1 = [1,2,3,4]
			let array2 = [5,5,5,3]
			let result = combineArrays(array1,array2) {
				$0 * $1 //infer parameters
			}
	}

	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		print(theMostBasicClosure())
		print(paramClosure(1.1))
		print(paramClosureReturnVal(1))
		//pass function as parameter
		print(operationsSq(a:2,b:2, myFunction: addSquareFunc)) //a^2 + b^2 prints 8
		
		testArrays()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	//MARK: actions
	@IBAction func ShowTable(_ sender: Any) {
		let r = ResultsTableViewController()
		r.title_update = self
		//the callback function
		r.callback = {(_ num: Int) -> Void in
			//print selected row index from table view
			print(num)
		
		}
		
		// Don't need "() -> Void in" if no parameters and void
		r.anotherCallback = {
			print("do stuff callback")
		}
	
		let nc = self.navigationController
		nc?.pushViewController(r, animated: true)
		//show(r, sender: self)

		
	}

}

