//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Sahid Reza on 14/12/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var temparetureLabel: UILabel!
    
    @IBOutlet weak var temapretureImage: UIImageView!
    
    
    @IBOutlet weak var tempratureLocation: UILabel!
    
    
    var weatherManagement = WeatherManaagement()
    let locationManger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
      

       
        
        searchTextField.delegate = self
        weatherManagement.delegate = self
        
    }
    
    
    @IBAction func locationPress(_ sender: UIButton) {
        
        locationManger.requestLocation()
    }
    
    
}

//MARK: - UIText Field Delegate

extension WeatherViewController:UITextFieldDelegate {
    
    @IBAction func searchPress(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text != "" {
            
            return true
        } else {
            textField.placeholder = "Type Something here"
            
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            
            weatherManagement.fetchingWeather(cityname: city)
        }
        
        searchTextField.text = ""
    }
    
    
}

// MARK: - Weather Manager Delegate



extension WeatherViewController: WeatherManaagementDelegate{
    
    func didUpdateWeather(_ weatherManager:WeatherManaagement, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            self.temparetureLabel.text = weather.temparetureSting
            self.temapretureImage.image = UIImage(systemName: weather.conditionName)
            self.tempratureLocation.text = weather.cityName
        }
        
        
        
    }
    
    func didFaildwithError(error: Error) {
        print(error.localizedDescription)
    }
    
}

// MARK: - CL LOCATION MANAGER DELEGATE

extension WeatherViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
           if let location = locations.last{
            locationManger.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManagement.fetchingWeather(latitude: lat, lodnitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
    }
    
    
}

