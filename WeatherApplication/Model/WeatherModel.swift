//
//  WeatherModel.swift
//  WeatherApplication
//
//  Created by Sahid Reza on 24/12/22.
//

import Foundation

struct WeatherModel{
    
    let conditioniD: Int
    let cityName:String
    let temareture: Double
    
    var temparetureSting:String {
        
        return String(format: "%.1f", temareture)
    }
    
    var conditionName: String {
        
        switch conditioniD {
            
        case 200...232:
            
            return "cloud.bolt"
            
        case 300...321:
            
            return "cloud.drizzle"
            
        case 500...531:
            
            return "cloud.rain"
            
        case 600...622:
            
            return "cloud.snow"
            
        case 701...781:
            
            return "cloud.fog"
            
        case 800:
            return "sun.max"
            
        case 801...804:
            
            return "cloud.bolt"
            
        default:
            
            return "cloud"
        }
        
    }
    
}
