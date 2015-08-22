//
//  ViewController.swift
//  WeatherApp
//
//  Created by Raheel Kazi on 8/17/15.
//  Copyright (c) 2015 Raheel Kazi. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBAction func calculateWeather(sender: AnyObject) {
        if !cityName.text.isEmpty{
            var cityWeather = WeatherMap()
            cityWeather.cityName = cityName.text
            var weatherDict : [String : String] = cityWeather.getWeather()
            
            //Only set labels on success Json
            if weatherDict["cod"] == "200"{
                setLabels(weatherDict)
            }
            
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
        // Do any additional setup after loading the view, typically from a nib.
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

