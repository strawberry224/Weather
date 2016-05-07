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
    
    // Save access to local location
    var currLocation : CLLocation!

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        loadLocation()
        
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
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
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
        geocoder.reverseGeocodeLocation(currLocation) { (placemark, error) -> Void in
            
            if(error == nil) {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                
                // city
                let city: String = (mark.addressDictionary! as NSDictionary).valueForKey("City") as! String
                var State: String = (mark.addressDictionary! as NSDictionary).valueForKey("State") as! String
                
                State = State.stringByReplacingOccurrencesOfString("省", withString: "")
                let citynameStr = city.stringByReplacingOccurrencesOfString("市", withString: "")
                
                print(citynameStr)
            }
            else {
                print(error)
            }
        }
    }
}
