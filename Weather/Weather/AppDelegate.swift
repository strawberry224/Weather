//
//  AppDelegate.swift
//  Weather
//
//  Created by Shen Lijia on 16/1/31.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var locationManager = CLLocationManager()
    
    // API Configuration
    var httpUrl = "http://apis.baidu.com/heweather/weather/free"
    var httpCity = "city=?"
    let aqiKey = "616e8a401061a1108d387543235f3159"
    
    var getMemberValue = GetMemberValue()
    var noticeSetting = NoticeSetting()
    
    // Save access to local location
    var currLocation : CLLocation!
    
    func getPushTime(pushTime: Float) -> Float {
        
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        
        // The date format is "hours, minutes and seconds"
        dateFormatter.dateFormat = "HH,mm,ss"
        
        // The device's current time (24-hour)
        let strDate = dateFormatter.stringFromDate(date)
        
        // The hours, minutes, seconds, split out into an array
        let dateArr = strDate.componentsSeparatedByString(",")
        
        // Unified converted into seconds
        let hour = ((dateArr[0] as NSString).floatValue)*60*60
        let minute = ((dateArr[1] as NSString).floatValue)*60
        let second = (dateArr[2] as NSString).floatValue
        var newPushTime = Float()
        
        if hour > pushTime {
            newPushTime = 24*60*60-(hour+minute+second)+pushTime
        } else {
            newPushTime = pushTime-(hour+minute+second)
        }

        return newPushTime
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //loadLocation()

        // Override point for customization after application launch.
        // loadLocation()
        
        // Open notifications
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound],
                                                  categories: nil)
        application.registerUserNotificationSettings(settings)
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        //if (UIApplication.sharedApplication().scheduledLocalNotifications!.count == 0) {
        
        let notification = UILocalNotification()
        
        // Push local time (7 am temporarily)
        var pushTime: Float = 7*60*60
        var fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(getPushTime(pushTime)))

        if (noticeSetting.mergeMorningStrings() != "") {

            // Setting the time Push
            notification.fireDate = fireDate
            
            // setting timeZone as localTimeZone
            notification.timeZone = NSTimeZone.localTimeZone()
            notification.repeatInterval = NSCalendarUnit.Day
            notification.alertTitle = "Weather"
            notification.alertBody = noticeSetting.mergeMorningStrings()
            notification.alertAction = "OK"
            notification.soundName = UILocalNotificationDefaultSoundName
            
            // setting app‘s icon badge
            notification.applicationIconBadgeNumber = 1
            
            var userInfo:[NSObject : AnyObject] = [NSObject : AnyObject]()
            userInfo["kLocalNotificationID"] = "LocalNotificationID"
            userInfo["key"] = "Attention Please"
            notification.userInfo = userInfo
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        
        if (noticeSetting.mergeEveningStrings() != "") {
        
            // Push local time (10 pm temporarily)
            pushTime = 22*60*60
            fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(getPushTime(pushTime)))
            
            // Setting the time Push
            notification.fireDate = fireDate
            notification.alertBody = noticeSetting.mergeEveningStrings()
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        
        if (noticeSetting.mergeEveningStrings() != "") {

            fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(0))
            
            // Setting the time Push
            notification.fireDate = fireDate
            notification.alertBody = noticeSetting.mergeCurrentStrings()
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        //}
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        application.applicationIconBadgeNumber = 0
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

extension AppDelegate: CLLocationManagerDelegate {
    
    // Open Location
    func loadLocation() {
        locationManager.delegate = self
        
        // Targeting
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // iOS8.0 above before you can use
        if(UIDevice.currentDevice().systemVersion >= "8.0"){
            
            // Always allow access to location information
            locationManager.requestAlwaysAuthorization()
            
            // Use the application period to allow access to location data
            locationManager.requestWhenInUseAuthorization()
        }
        
        // Turn on location
        locationManager.startUpdatingLocation()
    }
    
    // Get location information
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Obtain an array of locations last
        let location:CLLocation = locations[locations.count-1]
        currLocation = locations.last!
        
        // Determine whether the empty
        if(location.horizontalAccuracy > 0){
            LonLatToCity()
            
            // Stop Location
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    // An error occurred
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print(error)
    }
    
    // The latitude and longitude is converted to the city name
    func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        var citynameStr = "hangzhou"
        geocoder.reverseGeocodeLocation(currLocation) { (placemark, error) -> Void in
            
            if(error == nil) {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                
                // city
                let city: String = (mark.addressDictionary! as NSDictionary).valueForKey("City") as! String
                var State: String = (mark.addressDictionary! as NSDictionary).valueForKey("State") as! String
                
                State = State.stringByReplacingOccurrencesOfString("省", withString: "")
                citynameStr = city.stringByReplacingOccurrencesOfString("市", withString: "")
                
                } else {
                print(error)
            }
        }
        httpCity = "city=" + citynameStr
        // httpCity = "city=hangzhou"
        print(httpCity)
        self.request(httpUrl, httpCity: httpCity)
    }
    
    func  request(httpUrl: String, httpCity: String) {
        let request = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpCity)!)
        let session = NSURLSession.sharedSession()
        request.timeoutInterval = 6
        request.HTTPMethod = "GET"
        request.addValue(aqiKey, forHTTPHeaderField: "apikey")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (d, response, error) -> Void in
            
            if let _ = error{
                print("请求失败")
            }
            if let _ = d {
                self.testJson(d!)
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
                            if (self.getMemberValue.getCityAQI(city).aqi > 100) {
                                self.noticeSetting.aqiFlag = true
                            }
                        }
                    }

                    if let DailyForecastArray = aStatus["daily_forecast"] as? NSArray {
                        // today weather
                        var minToday = 0
                        var maxToday = 0
                        
                        if let DailyForecast = DailyForecastArray[0] as? NSDictionary {
                            let daily = self.getMemberValue.getDailyForecast(DailyForecast)
                            
                            minToday = (daily.tmp?.min)!
                            maxToday = (daily.tmp?.max)!
                            
                            if (maxToday > 40) {
                                self.noticeSetting.maxTmpFlag = true
                            }
                            
                            if (minToday < 0) {
                                self.noticeSetting.minTmpFlag = true
                            }
                            
                            if (maxToday - minToday > 10) {
                                self.noticeSetting.diffTmpFlag = true
                            }
                            
                            if (daily.pcpn > 0) {
                                self.noticeSetting.pcpnFlag = true
                            }

                        }
                        
                        // tomorrow weather
                        if let DailyForecast = DailyForecastArray[1] as? NSDictionary {
                            let daily = self.getMemberValue.getDailyForecast(DailyForecast)
                            
                            let minTomorrow = (daily.tmp?.min)!
                            let maxTomorrow = (daily.tmp?.max)!
                            
                            if (abs(minTomorrow - minToday) > 10 || abs(maxTomorrow - maxToday) > 10) {
                                self.noticeSetting.tomrrowTmpFlag = true
                            }
                            
                            if (daily.pcpn > 0) {
                                self.noticeSetting.pcpnFlag = true
                            }
                        }

                    
                    }
                    if let HourlyForecastArray = aStatus["hourly_forecast"] as? NSArray {
                        
                        var tmp = 0
                        
                        if let HourlyForecast = HourlyForecastArray[0] as? NSDictionary {
                            let hourly = self.getMemberValue.getHourlyForecast(HourlyForecast)
                            tmp = hourly.tmp!
                        }
                        
                        if (HourlyForecastArray.count > 1) {
                        
                            if let HourlyForecast = HourlyForecastArray[1] as? NSDictionary {
                                let hourly = self.getMemberValue.getHourlyForecast(HourlyForecast)
                                
                                if (hourly.pop > 0) {
                                    self.noticeSetting.hourPopFlag = true
                                }
                                
                                if (abs(hourly.tmp! - tmp) > 10) {
                                    self.noticeSetting.hourTmpFlag = true
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
}
