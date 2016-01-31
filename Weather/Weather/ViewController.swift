//
//  ViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/1/31.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func btnPressed(sender: AnyObject) {
        print("Button Pressed")
    }
    
    var httpUrl = "http://apis.baidu.com/heweather/weather/free"
    var httpCity = "city=hangzhou"
    let aqiKey = "616e8a401061a1108d387543235f3159"
    
    func getWeatherData() {
        request(httpUrl, httpCity: httpCity)
    }
    
    func  request(httpUrl: String, httpCity: String) {
        let request = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpCity)!)
        let session = NSURLSession.sharedSession()
        request.timeoutInterval = 6
        request.HTTPMethod = "GET"
        request.addValue(aqiKey, forHTTPHeaderField: "apikey")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            let result = response as! NSHTTPURLResponse
            print(result.statusCode)
            if let _ = error{
                print("请求失败")
            }
            if let _ = data {
//                let content = NSString(data: d, encoding: NSUTF8StringEncoding)
//                print(content)
                self.testJson(data!)
            }
        })
        task.resume()
    }
    
    func testJson(data: NSData) {
        let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        let weatherInfo = jsonObject.objectForKey("HeWeather data service 3.0")!
        
        print(weatherInfo)
        if let statusesArray = weatherInfo as? NSArray {
            if let aStatus = statusesArray[0] as? NSDictionary {
                if let aqi = aStatus["aqi"] as? NSDictionary {
                    if let city = aqi["city"] as? NSDictionary {
                        getCityAqi(city)
                    }
                }
            }
        }
    }
    
    var weatherData = WeatherData()
    var cityAQI = WeatherData.CityAQI()
    
    func getCityAqi(city: NSDictionary) {
        cityAQI.aqi = Int(city["aqi"]!.integerValue)
        cityAQI.co = Int(city["co"]!.integerValue)
        cityAQI.no2 = Int(city["no2"]!.integerValue)
        cityAQI.o3 = Int(city["o3"]!.integerValue)
        cityAQI.pm10 = Int(city["pm10"]!.integerValue)
        cityAQI.pm25 = Int(city["pm25"]!.integerValue)
        cityAQI.qlty = String(city["qlty"]!)
        cityAQI.so2 = Int(city["so2"]!.integerValue)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

