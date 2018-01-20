//
//  TableViewController.swift
//  TableViewProject_Swift
//
//  Created by Loud on 1/11/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

import Foundation
import UIKit


class DetailsViewController: UIViewController {
	@IBOutlet weak var selectedIndex: UILabel!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
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
			//swift async call
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
		let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController

		//Can use:
			//showDetailViewController(controller, sender: self)
		//or..
		self.present(controller, animated: true, completion: {
			//populate as completion(slight delay)
			controller.selectedIndex.text = String(indexPath.row)
		})
		
		//...or Populate subviews after show detail is called(no delay)
		//controller.selectedIndex.text = String(indexPath.row)
		
		//show alert with Objective-C utility
		//utility.showAlert(withTitle: "hello", andMessage: "mess", andVC: self)
		
	}
	
}
