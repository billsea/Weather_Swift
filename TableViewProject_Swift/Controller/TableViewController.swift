//
//  TableViewController.swift
//  TableViewProject_Swift
//
//  Created by Loud on 1/11/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

import Foundation
import UIKit

//MARK: Declare Protocol
protocol update_delegate {
	func name_update(label:String)
}

class DetailsViewController: UIViewController {
	@IBOutlet weak var selectedIndex: UILabel!
	var sel_index:String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		//set subview values
		self.selectedIndex.text = "row:" + self.sel_index!
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

class CustomTableViewCell: UITableViewCell {

	@IBOutlet weak var my_image: UIImageView!
	@IBOutlet weak var my_label: UILabel!
	@IBOutlet weak var descLabel: UILabel!
	
}

class ResultsTableViewController: UITableViewController {
	
	//Declare callback closure (like obj-c block)
	//Note: needs optional in declaration(?)
	var callback: ((_ returnValue: Int) -> Void)?
	
	//Void callback with no parameters
	var anotherCallback: (() -> ())?
	
	//declare test protocol (must be var)
	var title_update: update_delegate!
	
	var _table_data:[ListValues]?
	let cellIdentifier = "custom_cell"
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		//Use NIB for custom cell - Prototype is confusing
		tableView.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
		
		//MARK: Begin REST Request
		RequestData().BeginRequest() { (json_result) -> Void in
			//Swift async call
			DispatchQueue.main.async() {
				//parse JSON result
				self._table_data = WeatherData.init(json: json_result!)?.weather_info_list
				self.tableView.reloadData()
			}
		}
		
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard _table_data != nil else {
			return 0
		}
		return _table_data!.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		//Use NIB for custom cell
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
		cell.my_label.text = String(format: "%.2f", self._table_data![indexPath.row].temp_day!)
		cell.descLabel.text = self._table_data![indexPath.row].weather_desc?.description!
		cell.my_image.backgroundColor = UIColor.purple

		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
		detailsVC.sel_index = String(indexPath.row)
		self.navigationController?.pushViewController(detailsVC, animated: true)
		
		//Can use:
			//showDetailViewController(detailsVC, sender: self)
		//or..
//		self.present(detailsVC, animated: true, completion: {
//			//populate as completion(slight delay)
//			detailsVC.selectedIndex.text = String(indexPath.row)
//		})
		
		//Examples of calling Objective-C method and a Callback
		
		//show alert with Objective-C utility
		//utility.showAlert(withTitle: "hello", andMessage: "mess", andVC: self)
		
		//callback to ViewController function
		self.callback!(indexPath.row)
		self.anotherCallback!()
		
		//protocol
		title_update.name_update(label: "my name")
		
		
	}
	
	
}
