//
//  Constants.swift
//  cloudyshinyrainy
//
//  Created by Chris Rogers on 10/24/16.
//  Copyright © 2016 Rogers. All rights reserved.
//

import Foundation

let CURRENT_BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat=32"
let LONGITUDE = "&lon=32"
let APP_ID = "&appid="
let API_KEY = "f2bd6a441dc6c62d116e1ea7f2eb3c2a"

//tells when data is finished downloading
typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=f2bd6a441dc6c62d116e1ea7f2eb3c2a"
let FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=f2bd6a441dc6c62d116e1ea7f2eb3c2a"


