//
//  weather.swift
//  TableViewProject_Swift
//
//  Created by Loud on 1/16/18.
//  Copyright © 2018 loudsoftware. All rights reserved.
//

import Foundation
import Gloss

//struct WeatherData: JSONDecodable {
//	let temp: Float?
//	let pressure: Int?
//
//	init?(json: JSON) {
//		temp = "main.temp" <~~ json
//		pressure = "main.pressure" <~~ json
//	}
//
//}


//array elements
struct Temps : JSONDecodable {
	let day:String?
	
	init?(json: JSON) {
		guard let day: String = "day" <~~ json else {
			return nil
		}
		self.day = day
	}
}

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
	let temps:Temps?

	init?(json: JSON) {
		guard let pressure: Float = "pressure" <~~ json else {
			return nil
		}
		self.pressure = pressure
		
		guard let weather_desc = [WeatherDesc].from(jsonArray: ("weather" <~~ json)!) else {
			return nil
		}
		self.weather_desc = weather_desc[0] //this is an array, but just return first index
		
		self.temps = "temp" <~~ json //TODO: this is array?
	}
}
struct WeatherData: JSONDecodable {
	let lvalues: [ListValues]?
	
	init?(json: JSON) {
		guard let list_values = [ListValues].from(jsonArray: ("list" <~~ json)!) else {
			// handle decoding failure here
			return nil
		}
		lvalues = list_values
	}
}

