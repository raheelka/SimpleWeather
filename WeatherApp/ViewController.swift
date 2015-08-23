//
//  ViewController.swift
//  WeatherApp
//
//  Created by Raheel Kazi on 8/17/15.
//  Copyright (c) 2015 Raheel Kazi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var latitude : Int! = 0
    var longitude : Int! = 0
    
    let locationManager = CLLocationManager()
    
    @IBAction func calculateWeather(sender: AnyObject) {
        if !cityName.text.isEmpty{
            var cityWeather = WeatherMap()
            var weatherDict : [String : String] = cityWeather.getWeather(cityName.text, lat: nil, lon: nil, factory: "ByCity")
            
            //Only set labels on success Json
            if weatherDict["cod"] == "200"{
                setLabels(weatherDict)
            }
            
        }
    }
    
    @IBAction func calculateCurrentLocationWeather(sender: UIButton) {
        getCurrentLocation()
        var cityWeather = WeatherMap()
        var weatherDict : [String : String] = cityWeather.getWeather(nil , lat: self.latitude, lon: self.longitude, factory: "ByLatLon")
        
        //Only set labels on success Json
        if weatherDict["cod"] == "200"{
            setLabels(weatherDict)
        }
    }
    
    func setLabels(weatherDict : [String : String]){
        cityLabel.text = weatherDict["city"]
        tempLabel.text = weatherDict["temp"]! + "\u{00B0}" + "C"
        var weathercond : AnyObject! = weatherDict["weathercondition"]
        println("\(weathercond)")
        var img : UIImage! = UIImage(named: "\(weathercond)")
        backgroundImage.image = img
        weatherDescriptionLabel.text = weatherDict["weatherDescription"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
    }
    
    func getCurrentLocation(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        self.latitude = Int(locValue.latitude)
        self.longitude = Int(locValue.longitude)
        println("locations = \(Int(locValue.latitude))" + ", " + "\(Int(locValue.longitude))")
        self.locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }


}

