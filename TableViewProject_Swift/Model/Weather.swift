//
//  weather.swift
//  TableViewProject_Swift
//
//  Created by Loud on 1/16/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

import Foundation
import Gloss

struct WeatherDesc : JSONDecodable {
	let description:String?
	
	init?(json: JSON) {
		guard let description: String = "description" <~~ json else {
			return nil
		}
		self.description = description
	}
}

struct ListValues : JSONDecodable {
	let pressure:Float?
	let weather_desc:WeatherDesc?
	var temp_day:Float?
	
	init?(json: JSON) {
		//use guard/assert to validate
		guard let pressure: Float = "pressure" <~~ json else {
			return nil
		}
		self.pressure = pressure
		
		self.temp_day = "temp.day" <~~ json //gets value without guard/assert
		
		//gets weather nested array
		guard let weather_desc = [WeatherDesc].from(jsonArray: ("weather" <~~ json)!) else {
			return nil
		}
		self.weather_desc = weather_desc[0] //this is an array, but just return first index

	}
}

struct WeatherData: JSONDecodable {
	let weather_info_list: [ListValues]?
	
	init?(json: JSON) {
		guard let list_values = [ListValues].from(jsonArray: ("list" <~~ json)!) else {
			// handle decoding failure here
			return nil
		}
		self.weather_info_list = list_values
	}
}

