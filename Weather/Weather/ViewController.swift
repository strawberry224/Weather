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

    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var degreeButton: UIButton!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!

    @IBOutlet weak var dayZeroTemperatureLow: UILabel!
    @IBOutlet weak var dayZeroTemperatureHigh: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var dayZeroWeekDayLabel: UILabel!
    @IBOutlet weak var dayZeroImage: UIImageView!
    @IBOutlet weak var dayZeroHighLow: UILabel!
    
    @IBOutlet weak var dayOneWeekDayLabel: UILabel!
    @IBOutlet weak var dayOneImage: UIImageView!
    @IBOutlet weak var dayOneHighLow: UILabel!
    
    @IBOutlet weak var dayTwoWeekDayLabel: UILabel!
    @IBOutlet weak var dayTwoImage: UIImageView!
    @IBOutlet weak var dayTwoHighLow: UILabel!
    
    @IBOutlet weak var dayThreeWeekDayLabel: UILabel!
    @IBOutlet weak var dayThreeImage: UIImageView!
    @IBOutlet weak var dayThreeHighLow: UILabel!
    
    @IBOutlet weak var dayFourWeekDayLabel: UILabel!
    @IBOutlet weak var dayFourImage: UIImageView!
    @IBOutlet weak var dayFourHighLow: UILabel!
    
    @IBOutlet weak var dayFiveWeekDayLabel: UILabel!
    @IBOutlet weak var dayFiveImage: UIImageView!
    @IBOutlet weak var dayFiveHighLow: UILabel!
    
    @IBOutlet weak var daySixWeekDayLabel: UILabel!
    @IBOutlet weak var daySixImage: UIImageView!
    @IBOutlet weak var daySixHighLow: UILabel!
    
    var dayWeekDayLabel = [UILabel!]()
    var dayImage = [UIImageView!]()
    var dayHighLow = [UILabel!]()
    
    var httpUrl = "http://apis.baidu.com/heweather/weather/free"
    var httpCity = "city=hangzhou"
    let aqiKey = "616e8a401061a1108d387543235f3159"
    
    func loadWeatherData() {
        
        request(httpUrl, httpCity: httpCity)
    }
    
    func loadDayWeekDayLabel() {
        
        dayWeekDayLabel.append(dayZeroWeekDayLabel)
        dayWeekDayLabel.append(dayOneWeekDayLabel)
        dayWeekDayLabel.append(dayTwoWeekDayLabel)
        dayWeekDayLabel.append(dayThreeWeekDayLabel)
        dayWeekDayLabel.append(dayFourWeekDayLabel)
        dayWeekDayLabel.append(dayFiveWeekDayLabel)
        dayWeekDayLabel.append(daySixWeekDayLabel)
    }
    
    func loadDayImage() {
        
        dayImage.append(dayZeroImage)
        dayImage.append(dayOneImage)
        dayImage.append(dayTwoImage)
        dayImage.append(dayThreeImage)
        dayImage.append(dayFourImage)
        dayImage.append(dayFiveImage)
        dayImage.append(daySixImage)
    }
    
    func loadDayHighLow() {
        
        dayHighLow.append(dayZeroHighLow)
        dayHighLow.append(dayOneHighLow)
        dayHighLow.append(dayTwoHighLow)
        dayHighLow.append(dayThreeHighLow)
        dayHighLow.append(dayFourHighLow)
        dayHighLow.append(dayFiveHighLow)
        dayHighLow.append(daySixHighLow)
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
        
        loadDayWeekDayLabel()
        loadDayImage()
        loadDayHighLow()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let weatherInfo = jsonObject.objectForKey("HeWeather data service 3.0")!
            
            if let statusesArray = weatherInfo as? NSArray {
                if let aStatus = statusesArray[0] as? NSDictionary {
                    if let aqi = aStatus["aqi"] as? NSDictionary {
                        if let city = aqi["city"] as? NSDictionary {
                           self.cityAQI = self.getMemberValue.getCityAQI(city)
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
                                
                                let daily = self.cityDailyForecast[index]
                                let date = (daily.date! as NSString).substringFromIndex(8)
                                self.dayWeekDayLabel[index].text = date
                                let image = (daily.cond?.codeD)!
                                self.dayImage[index].image = UIImage(named: "\(image)")
                                let min = (daily.tmp?.min)!
                                let max = (daily.tmp?.max)!
                                self.dayHighLow[index].text = "\(min)" + "~" + "\(max)"
                            }
                        }
                        
                        let daily = self.cityDailyForecast[0]
                        let min = (daily.tmp?.min)!
                        let max = (daily.tmp?.max)!
                        self.dayZeroTemperatureLow.text = "\(min)"
                        self.dayZeroTemperatureHigh.text = "\(max)"
      
                        let sc = (daily.wind?.sc)!
                        self.windSpeedLabel.text = "\(sc)"
                        
                        let pcpn = (daily.pcpn)!
                        self.rainLabel.text = "\(pcpn)"
                        
                        let hum = (daily.hum)!
                        self.humidityLabel.text = "\(hum)"
                        
                    }
                    if let HourlyForecastArray = aStatus["hourly_forecast"] as? NSArray {
                        self.cityDailyForecast.removeAll()
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
        userLocationLabel.text = aString
        loadWeatherData()
    }


}

