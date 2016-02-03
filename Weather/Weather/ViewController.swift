//
//  ViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/1/31.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBAction func btnPressed(sender: AnyObject) {
        loadWeatherData()
    }
    
    @IBOutlet weak var tv: UITextView!
    
    var httpUrl = "http://apis.baidu.com/heweather/weather/free"
    var httpCity = "city=hangzhou"
    let aqiKey = "616e8a401061a1108d387543235f3159"
    
    func loadWeatherData() {
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
    
    // Save access to local location
    var currLocation : CLLocation!
    
    // For positioning service management class
    // it can provide us with location information and height information
    // also can monitor the equipment to enter or leave a certain area
    // but also can obtain the operation direction of equipment
    let locationManager : CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set location service manager proxy
        locationManager.delegate = self
        
        // Send authorization request
        locationManager.requestAlwaysAuthorization()
        
        // The highest accuracy when the device is powered by a battery
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Accurate to 1000 meters
        // distance filter
        // defined the minimum distance of the device to get the position information after moving
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.locationServicesEnabled() {
            
            // To allow the use of the location of the service
            // then open the positioning service updates
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        currLocation = locations.last! as CLLocation
        LonLatToCity()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Change the latitude and longitude into a city name
    func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemark, error) -> Void in
            
            // Convert to success
            // parse all the information
            if (error == nil) {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                var SubLocality: NSString = (mark.addressDictionary! as NSDictionary).valueForKey("SubLocality") as! NSString
                
                // Remove the word "city" and "province"
                SubLocality = SubLocality.stringByReplacingOccurrencesOfString("市", withString: "")
                self.charactorType(SubLocality as String)
                //print(self.cityName)
            }else {
                // conversion failed
            }
        })
    }
    
    func charactorType(aString:String) {
        
        // Conversion failed to convert to variable string
        let str = NSMutableString(string: aString)
        CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
        
        // And then converted to Pinyin without tone
        CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
        let res = str as NSString
        httpCity = "city=" + res.stringByReplacingOccurrencesOfString(" ", withString: "")
        tv.text = aString
    }


}

