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
                self.testJson(data!)
            }
        })
        task.resume()
    }
    
    func testJson(data: NSData) {
        let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
        let weatherInfo = jsonObject.objectForKey("HeWeather data service 3.0")!
        
        if let statusesArray = weatherInfo as? NSArray {
            if let aStatus = statusesArray[0] as? NSDictionary {
                if let aqi = aStatus["aqi"] as? NSDictionary {
                    if let city = aqi["city"] as? NSDictionary {
                       cityAQI = getMemberValue.getCityAQI(city)
                    }
                }
                if let basic = aStatus["basic"] as? NSDictionary {
                    cityBasic = getMemberValue.getBasic(basic)
                }
                if let DailyForecastArray = aStatus["daily_forecast"] as? NSArray {
                    cityDailyForecast.removeAll()
                    for index in 0...DailyForecastArray.count - 1 {
                        if let DailyForecast = DailyForecastArray[index] as? NSDictionary {
                            cityDailyForecast.append(getMemberValue.getDailyForecast(DailyForecast))
                        }
                    }
                }
                if let HourlyForecastArray = aStatus["hourly_forecast"] as? NSArray {
                    cityDailyForecast.removeAll()
                    for index in 0...HourlyForecastArray.count - 1 {
                        if let HourlyForecast = HourlyForecastArray[index] as? NSDictionary {
                            cityHourlyForecast.append(getMemberValue.getHourlyForecast(HourlyForecast))
                        }
                    }
                }
                if let now = aStatus["now"] as? NSDictionary {
                    cityNow = getMemberValue.getNow(now)
                }
                if let sugguestion = aStatus["suggestion"] as? NSDictionary {
                    citySuggestion = getMemberValue.getSuggestion(sugguestion)
                }
            }
        }
    }
    
    var weatherData = WeatherData()
    var cityAQI = WeatherData.CityAQI()
    var cityBasic = WeatherData.Basic()
    var cityDailyForecast = [WeatherData.DailyForecast()]
    var cityHourlyForecast = [WeatherData.HourlyForecast()]
    var cityNow = WeatherData.Now()
    var citySuggestion = WeatherData.Suggestion()
    var getMemberValue = GetMemberValue()
    
    
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

