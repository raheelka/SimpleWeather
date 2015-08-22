//
//  WeatherMap.swift
//  WeatherApp
//
//  Created by Raheel Kazi on 8/20/15.
//  Copyright (c) 2015 Raheel Kazi. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
}

class WeatherMap {
    
    var cityName : String! = ""
    
    
    func convertKelvinToDegrees(temp : Int) -> Int{
        return temp - 273
    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        
        return boardsDictionary
    }
    
    func getWeatherDataFromJson()->AnyObject{
        var cleanCity = self.cityName.removeWhitespace()
        let urlPath = "http://api.openweathermap.org/data/2.5/weather?q=\(cleanCity)"
        var data = getJSON(urlPath)
        var weatherData = parseJSON(data)
        //TODO Check weatherData for 404 error
        return weatherData
    }
    
    func getWeather()->[String : String]{
        var weatherData : AnyObject = getWeatherDataFromJson()
        let weatherArray = weatherData["weather"] as! NSArray
        
        let city: AnyObject! = weatherData["name"]
        let weatherCondition : AnyObject! = weatherArray[0]["main"]
        let weatherDescription : AnyObject! = weatherArray[0]["description"]
        
        var weatherDict = [String: String]()
        
        if let main: AnyObject = weatherData["main"]{
            if let temp = main["temp"] as? NSNumber{
                var temp_cel : String = "\(convertKelvinToDegrees(Int(temp)))"
                weatherDict["temp"] = temp_cel
                weatherDict["weathercondition"] = "\(weatherCondition)"
                weatherDict["city"] = "\(city)"
                weatherDict["weatherDescription"] = "\(weatherDescription)"
            }
        }
        return weatherDict
        
    }

    
}