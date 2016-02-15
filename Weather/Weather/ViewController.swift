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
    
    @IBOutlet weak var AQIButton: UIButton!
    
    @IBOutlet weak var dayZeroWeekDayButton: UIButton!
    @IBOutlet weak var dayOneWeekDayButton: UIButton!
    @IBOutlet weak var dayTwoWeekButton: UIButton!
    @IBOutlet weak var dayThreeWeekButton: UIButton!
    @IBOutlet weak var dayFourWeekButton: UIButton!
    @IBOutlet weak var dayFiveWeekButton: UIButton!
    @IBOutlet weak var daySixWeekButton: UIButton!
    
    @IBOutlet weak var dayZeroView: UIView!
    @IBOutlet weak var dayOneView: UIView!
    @IBOutlet weak var dayTwoView: UIView!
    @IBOutlet weak var dayThreeView: UIView!
    @IBOutlet weak var dayFourView: UIView!
    @IBOutlet weak var dayFiveView: UIView!
    @IBOutlet weak var daySixView: UIView!
    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savePlayerDetail(segue:UIStoryboardSegue) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func zeroButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func oneButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func twoButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func threeButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func fourButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func fiveButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func sixButtonPressed(sender: AnyObject) {
    }
    
    
    var dayWeekDayLabel = [UILabel!]()
    var dayImage = [UIImageView!]()
    var dayHighLow = [UILabel!]()
    var dayWeekButton = [UIButton!]()
    var dayWeekDayView = [UIView!]()
    
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
    
    func loadDayWeekDayButton() {
        
        dayWeekButton.append(dayZeroWeekDayButton)
        dayWeekButton.append(dayOneWeekDayButton)
        dayWeekButton.append(dayTwoWeekButton)
        dayWeekButton.append(dayThreeWeekButton)
        dayWeekButton.append(dayFourWeekButton)
        dayWeekButton.append(dayFiveWeekButton)
        dayWeekButton.append(daySixWeekButton)
    }
    
    func loadDayWeekDayView() {
        
        dayWeekDayView.append(dayZeroView)
        dayWeekDayView.append(dayOneView)
        dayWeekDayView.append(dayTwoView)
        dayWeekDayView.append(dayThreeView)
        dayWeekDayView.append(dayFourView)
        dayWeekDayView.append(dayFiveView)
        dayWeekDayView.append(daySixView)
    }
    
    func  request(httpUrl: String, httpCity: String) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpCity)!)
        let session = NSURLSession.sharedSession()
        //request.timeoutInterval = 6
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
        loadDayWeekDayButton()
        loadDayWeekDayView()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let weatherInfo = jsonObject.objectForKey("HeWeather data service 3.0")!
            
            if let statusesArray = weatherInfo as? NSArray {
                if let aStatus = statusesArray[0] as? NSDictionary {
                    if let aqi = aStatus["aqi"] as? NSDictionary {
                        if let city = aqi["city"] as? NSDictionary {
                            self.cityAQI = self.getMemberValue.getCityAQI(city)
                            
                            let colorNum = Float(self.cityAQI.aqi!)
                            let tmpColor = 255 - (colorNum - 50) * 10;
                            var red: Float = 0, green: Float = 0;
                            if (tmpColor > 255) {
                                red = 255;
                                green = 255 * 2 - tmpColor;
                            } else {
                                red = tmpColor;
                                green = 255;
                            }

                            self.AQIButton.backgroundColor = UIColor(colorLiteralRed: red, green: green, blue: 0, alpha: 1)
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
                                
                                let rectView = CGRect(x: 0, y: 95 - daily.pcpn! * 50, width: 40, height: daily.pcpn! * 50)
                                let dropView = UIView(frame: rectView)
                                dropView.backgroundColor = UIColor(red: 0, green: 0, blue: CGFloat(Double(daily.pop!) / 100), alpha: CGFloat(Double(daily.vis!) / 10.0))
                                let rectLabel = CGRect(x: 0, y: 85 - daily.pcpn! * 50, width: 40, height: 10)
                                let dropLabel = UILabel(frame: rectLabel)
                                dropLabel.text = "\(daily.pcpn!)" + "mm"
                                dropLabel.font = UIFont(name: "Helvetica", size: 10)
                                dropLabel.textAlignment = .Center
                                self.dayWeekDayView[index].addSubview(dropView)
                                self.dayWeekDayView[index].addSubview(dropLabel)
                                
                                // From the bottom of the animation effect
                                UIView.beginAnimations(nil, context: nil)
                                UIView.setAnimationDuration(2.0)
                                self.dayWeekDayView[index].center = CGPoint(x: 0, y: 0)
                                UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
                                UIView.commitAnimations()
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
                        
                        self.setBackgroundColor()
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
    
    func setBackgroundColor() {
        var time = (self.cityBasic.update?.loc!)! as NSString
        var hour = time.substringWithRange(NSMakeRange(11, 2))
        var minute = time.substringWithRange(NSMakeRange(14, 2))
        var h = Int(hour)!
        var m = Int(minute)!
        let updateTime = h * 60 + m
        
        time = (self.cityDailyForecast[0].astro?.sr)! as NSString
        hour = time.substringWithRange(NSMakeRange(0, 2))
        minute = time.substringWithRange(NSMakeRange(3, 2))
        h = Int(hour)!
        m = Int(minute)!
        let srTime = h * 60 + m
        
        time = (self.cityDailyForecast[0].astro?.ss)! as NSString
        hour = time.substringWithRange(NSMakeRange(0, 2))
        minute = time.substringWithRange(NSMakeRange(3, 2))
        h = Int(hour)!
        m = Int(minute)!
        let ssTime = h * 60 + m
        
        if updateTime <= srTime || updateTime >= ssTime {
            self.view.backgroundColor = UIColor.darkGrayColor()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let selectCityVC = segue.destinationViewController as? SelectCityViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "SelectCity":
                    selectCityVC.title = "!!!"
                default: break
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
        
        //self.navigationController?.navigationBarHidden = true
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
        self.navigationController?.navigationBarHidden = true
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
        httpCity = "city=hangzhou"
        userLocationButton.setTitle("当前城市：" + aString, forState: UIControlState.Normal)
        loadWeatherData()
    }


}

