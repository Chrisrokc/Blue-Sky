//
//  WeatherVC.swift
//  cloudyshinyrainy
//
//  Created by Chris Rogers on 10/12/16.
//  Copyright © 2016 Rogers. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //GPS Location Manager 
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    

    var currentWeather: CurrentWeather!
    var forcastWeather: Forecast!
    var forecasts = [Forecast]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    //Loading GPS Location Manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
    // Connects table. MUST HAVE!
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    // Getting Location and Authorizing
    func locationAuthStatus () {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                self.forecasts.remove(at: 0)
                self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    
    
// Main required functions for tableviews, MUST HAVE!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            //passing in forecast, which to use and when
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
            // if it breaks or no data
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

