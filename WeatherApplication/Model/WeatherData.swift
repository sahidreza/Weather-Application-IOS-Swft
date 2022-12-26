//
//  WeatherData.swift
//  WeatherApplication
//
//  Created by Sahid Reza on 24/12/22.
//

import Foundation

struct WeatherData:Decodable{
    let name:String
    let timezone:Int
    let main:Main
    let weather:[Weather]
}

struct Main:Decodable{
    
    let temp:Double
    
}

struct Weather:Decodable{
    let description:String
    let id:Int
}
