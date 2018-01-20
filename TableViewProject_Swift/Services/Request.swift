//
//  request.swift
//  TableViewProject_Swift
//
//  Created by Loud on 1/16/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

import Foundation

//can't use define in swift
//#define kResourceBaseURL @"http://api.openweathermap.org"

class RequestData {
	//request weather data and return value with handler(dictionary)
	//@escaping indicates that we will escape the functions when handler is called
	func BeginRequest(handler: @escaping (_ weather_data: Dictionary<String, AnyObject>?)-> Void) -> Void {
		//let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
		
//		var request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&appid=3ad67e7b46c13485e2d3d796d7d7cbd6")!)
		var request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=kingston,jm&cnt=16&appid=3ad67e7b46c13485e2d3d796d7d7cbd6")!)
		request.httpMethod = "GET"
		//request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		print(request)
		
		let session = URLSession.shared
		let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
			print(response!)
			do {
				let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
				print(json)
				//return json with handler
				handler(json)//escape function and return result
			} catch {
				print("error")
			}
		})
		task.resume()
	}
}




