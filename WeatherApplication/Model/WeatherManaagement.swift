//
//  WeatherManaagement.swift
//  WeatherApplication
//
//  Created by Sahid Reza on 23/12/22.
//

import Foundation
import CoreLocation

protocol WeatherManaagementDelegate{
   func didUpdateWeather(_ weatherManager:WeatherManaagement, weather: WeatherModel)
    func didFaildwithError(error:Error)
}

struct WeatherManaagement {
    
    var delegate:WeatherManaagementDelegate?
    
    let weatherUrl = "\(K.base_URL)weather?appid=\(K.apiKey)&units=metric"
    
    func fetchingWeather(cityname:String){
        let urlSting = "\(weatherUrl)&q=\(cityname)"
        performRequest(with: urlSting)
    }
    
    func fetchingWeather(latitude:CLLocationDegrees,lodnitude:CLLocationDegrees){
        
        let weatherUrl = "\(K.base_URL)weather?appid=\(K.apiKey)&units=metric&lat=\(latitude)&lon=\(lodnitude)"
        
        performRequest(with: weatherUrl)
        
    }
    
    func performRequest(with url:String){
        
        
        
        //1.create a url
        
        if let url = URL(string: url){
            
            //2.create a UrlSesion
            let sesion = URLSession(configuration: .default)
            
            //3. give a Session task
            
            let task = sesion.dataTask(with: url) { data, respone, error in
                
                if error != nil {
                    
                    self.delegate?.didFaildwithError(error: error!)
                    
                    return
                }
                
                if let safeData = data {
                    
                    if let weather =  self.passJson(safeData){
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                    
                }
            }
            
            //4. Start the stask
            task.resume()
        }
        
    }
    
    func passJson(_ weatherData:Data) -> WeatherModel?{
        
        let decoder = JSONDecoder()
        
        do{
            let decodeData =  try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weather = WeatherModel(conditioniD: id, cityName: name, temareture: temp)
            
            return weather
            
            
            
            
        }catch{
            self.delegate?.didFaildwithError(error: error)
            return nil
        }
        
        
        
    }
    
    
    
}
