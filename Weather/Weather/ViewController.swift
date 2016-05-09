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

class ViewController: UIViewController, CLLocationManagerDelegate, CityViewControllerDelegate, UIPopoverPresentationControllerDelegate { 
    
    // Define control
    @IBOutlet weak var userLocationButton: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var degreeButton: UIButton!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var dayZeroTemperatureLow: UILabel!
    @IBOutlet weak var dayZeroTemperatureHigh: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var WIND: UILabel!
    @IBOutlet weak var RAIN: UILabel!
    @IBOutlet weak var HUMIDITY: UILabel!
    
    @IBOutlet weak var AQIButton: UIButton!
    
    // API Configuration
    var httpUrl = "http://apis.baidu.com/heweather/weather/free"
    var httpCity = "city=?"
    let aqiKey = "616e8a401061a1108d387543235f3159"
    
    func loadWeatherData() {
        request(httpUrl, httpCity: httpCity)
    }
    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savePlayerDetail(segue:UIStoryboardSegue) {
        
        // if the city is legel, then can come back
        if (citySearchFlag == true) {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    // get flag of whether user input the city is legal
    var citySearchFlag = true
    func cityFlag(flag: Bool) {
        citySearchFlag = flag
    }
    
    func cityDidSelected(cityKey: String){
        charactorType(cityKey)
    }
    
    func  request(httpUrl: String, httpCity: String) {
        let request = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpCity)!)
        let session = NSURLSession.sharedSession()
        request.timeoutInterval = 6
        request.HTTPMethod = "GET"
        request.addValue(aqiKey, forHTTPHeaderField: "apikey")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
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
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let weatherInfo = jsonObject.objectForKey("HeWeather data service 3.0")!
            if let statusesArray = weatherInfo as? NSArray {
                if let aStatus = statusesArray[0] as? NSDictionary {
                    
                    if let aqi = aStatus["aqi"] as? NSDictionary {
                        if let city = aqi["city"] as? NSDictionary {
                            self.cityAQI = self.getMemberValue.getCityAQI(city)
                            
                            // set AQI value color from red to green
                            self.AQIButton.backgroundColor = normalization(self.cityAQI.aqi!)
                        }
                    }
                    if let basic = aStatus["basic"] as? NSDictionary {
                        self.cityBasic = self.getMemberValue.getBasic(basic)
                    }
                    if let DailyForecastArray = aStatus["daily_forecast"] as? NSArray {
                        self.cityDailyForecast.removeAll()
                        for index in 0...DailyForecastArray.count - 1 {
                            if let DailyForecast = DailyForecastArray[index] as? NSDictionary {
                                self.cityDailyForecast.append(self.getMemberValue.getDailyForecast(DailyForecast))
                            }
                        }
                        
                        let daily = self.cityDailyForecast[0]
                        let min = (daily.tmp?.min)!
                        let max = (daily.tmp?.max)!
                        self.dayZeroTemperatureLow.text = "\(min)"
                        self.dayZeroTemperatureHigh.text = "\(max)"
                        
                        // show wind speed value
                        let sc = (daily.wind?.sc)!
                        self.windSpeedLabel.text = "\(sc)"
                        
                        // show precipitation value
                        let pcpn = (daily.pcpn)!
                        self.rainLabel.text = "\(pcpn)"
                        
                        // show humidity value
                        let hum = (daily.hum)!
                        self.humidityLabel.text = "\(hum)"
                        
                        self.setBackgroundColor()
                    }
                    if let HourlyForecastArray = aStatus["hourly_forecast"] as? NSArray {
                        self.cityHourlyForecast.removeAll()
                        for index in 0...HourlyForecastArray.count - 1 {
                            if let HourlyForecast = HourlyForecastArray[index] as? NSDictionary {
                                self.cityHourlyForecast.append(self.getMemberValue.getHourlyForecast(HourlyForecast))
                            }
                        }
                    }
                    if let now = aStatus["now"] as? NSDictionary {
                        self.cityNow = self.getMemberValue.getNow(now)
                        self.temperatureLabel.text = "\(self.cityNow.tmp!)"
                        
                        let image = (self.cityNow.cond?.code)!
                        self.iconView.image = UIImage(named: "\(image)")
                        self.summaryLabel.text = self.cityNow.cond?.txt
                    }
                    if let sugguestion = aStatus["suggestion"] as? NSDictionary {
                        self.citySuggestion = self.getMemberValue.getSuggestion(sugguestion)
                    }
                }
            }
        })
    }
    
    var nightFlag = false
    func setBackgroundColor() {
        
        // Conversion now time to seconds
        var time = (self.cityBasic.update?.loc!)! as NSString
        var hour = time.substringWithRange(NSMakeRange(11, 2))
        var minute = time.substringWithRange(NSMakeRange(14, 2))
        var h = Int(hour)!
        var m = Int(minute)!
        let updateTime = h * 60 + m
        
        // Conversion sun rise time to seconds
        time = (self.cityDailyForecast[0].astro?.sr)! as NSString
        hour = time.substringWithRange(NSMakeRange(0, 2))
        minute = time.substringWithRange(NSMakeRange(3, 2))
        h = Int(hour)!
        m = Int(minute)!
        let srTime = h * 60 + m
        
        // Conversion sunset time to seconds
        time = (self.cityDailyForecast[0].astro?.ss)! as NSString
        hour = time.substringWithRange(NSMakeRange(0, 2))
        minute = time.substringWithRange(NSMakeRange(3, 2))
        h = Int(hour)!
        m = Int(minute)!
        let ssTime = h * 60 + m
        
        // if if now is night
        if updateTime <= srTime || updateTime >= ssTime {
            
            // set view background picture is bg_night.jpg
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_night")!)
            
            // set all text color is white
            userLocationButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            temperatureLabel.textColor = UIColor.whiteColor()
            degreeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            summaryLabel.textColor = UIColor.whiteColor()
            windSpeedLabel.textColor = UIColor.whiteColor()
            rainLabel.textColor = UIColor.whiteColor()
            humidityLabel.textColor = UIColor.whiteColor()
            WIND.textColor = UIColor.whiteColor()
            RAIN.textColor = UIColor.whiteColor()
            HUMIDITY.textColor = UIColor.whiteColor()
            nightFlag = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SelectCity" {
            
            // The transition to the CityViewController
            let destinationController = segue.destinationViewController as! UINavigationController
            let cityController = destinationController.viewControllers[0] as! CityViewController
            cityController.delegate = self;
            cityController.currentCity = currentCity
        } else if segue.identifier == "Forecast" {
            
            // The transition to the ForecastViewController
            let destinationController = segue.destinationViewController as! UINavigationController
            let forecastController = destinationController.viewControllers[0] as! ForecastViewController
            
            // transmit data
            forecastController.cityDailyForecast = cityDailyForecast
            
            // set background color of forecastController
            forecastController.nightFlag = nightFlag
        } else if segue.identifier == "ShowAQI" {
            
            // The transition to the AQIViewController
            let destinationController = segue.destinationViewController as! UINavigationController
            let aqiController = destinationController.viewControllers[0] as! AQIViewController
            
            // transmit data
            aqiController.cityAQI = cityAQI
        } else if segue.identifier == "ShowNow" {
            
            // The transition to the TodayViewController
            let destinationController = segue.destinationViewController as! UINavigationController
            let todayViewController = destinationController.viewControllers[0] as! TodayViewController
            
            // transmit data
            todayViewController.now = cityNow
            
            // set background color of hourlyForecastController
            todayViewController.nightFlag = nightFlag
        } else if segue.identifier == "HourlyForecast" {
            
            // The transition to the HourlyForecastViewController
            let destinationController = segue.destinationViewController as! UINavigationController
            let hourlyForecastController = destinationController.viewControllers[0] as! HourlyForecastViewController
            
            // transmit data
            hourlyForecastController.hourlyForecast = cityHourlyForecast
            hourlyForecastController.now = cityNow
            
            // set background color of hourlyForecastController
            hourlyForecastController.nightFlag = nightFlag
        } else if segue.identifier == "ShowSuggestion" {
            
            // The transition to the HourlyForecastViewController
//            let destinationController = segue.destinationViewController as! UINavigationController
//            let suggestionViewController = destinationController.viewControllers[0] as! SuggestionViewController
            
            let popoverViewController = segue.destinationViewController as! SuggestionViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            
            popoverViewController.citySuggestion = citySuggestion
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
    return UIModalPresentationStyle.None
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
    
    var suggestionViewController: SuggestionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_day")!)
        
        // self.navigationController?.navigationBarHidden = true
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
        if CLLocationManager.locationServicesEnabled() && httpCity == "city=?" {
            
            // To allow the use of the location of the service
            // then open the positioning service updates
            locationManager.startUpdatingLocation()
        }
        self.navigationController?.navigationBarHidden
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        currLocation = locations.last! as CLLocation
        LonLatToCity()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var currentCity: String?
    var getSubcityFlag = true
    
    // Change the latitude and longitude into a city name
    func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemark, error) -> Void in
            
            // Convert to success
            // parse all the information
            if (error == nil) {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                
                var subLocality = mark.name
                let provinceEndId = subLocality?.rangeOfString("省")?.endIndex
                let cityStartId = subLocality?.rangeOfString("市")?.startIndex
                
                if (provinceEndId == nil || cityStartId == nil) {
                    self.getSubcityFlag = false
                } else {
                    let range = Range(provinceEndId! ..< cityStartId!)
                    subLocality = subLocality?.substringWithRange(range)
                    
                }
                self.charactorType(subLocality)
            }else {
                // conversion failed
            }
        })
    }
    
    func charactorType(aString:String?) {
        
        // if the city name is nil, the default city is hangzhou
        // otherwise there will be a nil error
        if (getSubcityFlag == false) {
            httpCity = "city=hangzhou"
            userLocationButton.setTitle("当前城市：杭州", forState: UIControlState.Normal)
            
        } else {
            self.currentCity = aString
            // Conversion failed to convert to variable string
            let str = NSMutableString(string: aString!)
            CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
            
            // And then converted to Pinyin without tone
            CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
            let res = str as NSString
            httpCity = "city=" + res.stringByReplacingOccurrencesOfString(" ", withString: "")
            // httpCity = "city=hangzhou"
            userLocationButton.setTitle("当前城市：" + aString!, forState: UIControlState.Normal)
        }
        loadWeatherData()
    }
    
    
}