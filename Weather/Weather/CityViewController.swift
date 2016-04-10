//
//  SelectCityTableView.swift
//  Weather
//
//  Created by Shen Lijia on 16/2/18.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@objc protocol CityViewControllerDelegate {
    func cityDidSelected(cityKey: String)
    func cityFlag(flag: Bool)
}

class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var delegate: CityViewControllerDelegate?
    @IBOutlet weak var currentCityLabel: UILabel!
    @IBOutlet weak var inputCityName: UITextField!
    
    var flag = true
    
    // Save access to local location
    var currLocation : CLLocation!
    
    // For positioning service management class
    // it can provide us with location information and height information
    // also can monitor the equipment to enter or leave a certain area
    // but also can obtain the operation direction of equipment
    let locationManager : CLLocationManager = CLLocationManager()

    
    @IBAction func getUserPosition(sender: AnyObject) {
        
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
        
        if CLLocationManager.locationServicesEnabled() {
            
            // To allow the use of the location of the service
            // then open the positioning service updates
            locationManager.startUpdatingLocation()
        }

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
                
                var subLocality = mark.name
                let provinceEndId = subLocality?.rangeOfString("省")?.endIndex
                let cityStartId = subLocality?.rangeOfString("市")?.startIndex
                let range = Range(provinceEndId! ..< cityStartId!)
                subLocality = subLocality?.substringWithRange(range)
                self.currentCityLabel.text = "当前城市:  " + subLocality! as String
            }else {
                // conversion failed
            }
        })
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        currLocation = locations.last! as CLLocation
        LonLatToCity()
    }
        
    var currentCity: String?
    
    var tableView: UITableView?
    var items: NSArray = []
    var cityDictionary: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCityLabel.text = "当前城市:  " + currentCity!
        
        let plistPath = NSBundle.mainBundle().pathForResource("citylist", ofType: "plist")!
        let provinceArray = NSArray(contentsOfFile: plistPath)!
        cityDictionary = provinceArray[0] as? NSDictionary
        items = (cityDictionary?.allKeys)!
        
        // Create table view
        self.tableView = UITableView(frame: CGRectMake(0, 150, UIScreen.mainScreen().bounds.size.width,
            UIScreen.mainScreen().bounds.size.height), style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
        // Create a reusable cell
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        self.view.addSubview(self.tableView!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate & Datasource
    
    // The number of groups
    func numberOfRowsInSection(section: Int) -> Int{
        return 1
    }
    
    // Is specified in the UITableView how many section
    // section partition
    // a section will contain more than Cell
    // there is only one section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.items.count
    }
    
    // Is specified in each of the section which has a number of Cell.
    // Because we have only one section
    // how many cities have the number of optional Cell
    // This is depending on the situation.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.items.count
        let province:String = items[section] as! String
        let cityArray = cityDictionary![province]! as! NSArray
        return cityArray.count
    }
    
    
    // Initialize every Cell.
    // A Cell looks like it is determined by this method.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        //cell.textLabel?.text = items[indexPath.row] as? String
        
        let id = indexPath.section
        let province:String = items[id] as! String
        let cityArray = cityDictionary![province]! as! NSArray
        cell.textLabel?.text = cityArray[indexPath.row] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 30))
        view.backgroundColor = UIColor.grayColor()
        let provinceLabel = UILabel(frame:CGRectMake(0, 0, self.view.frame.size.width, 30))
        provinceLabel.text = items[section] as? String
        view.addSubview(provinceLabel)
        return view
    }
    
    // set header height
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // Is the method of selecting an Cell after execution.
    // When the user selects a cell, we need to know which one it is
    // and the cell of the city's name sent to the main interface used to access the city's weather data.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let id = indexPath.section
        let province:String = items[id] as! String
        let cityArray = cityDictionary![province]! as! NSArray
        let cityKey = cityArray[indexPath.row] as? String
        currentCityLabel.text = "当前城市:  " + cityKey!
        
        self.delegate?.cityDidSelected(cityKey!)
        
//        let mainViewController = storyboard?.instantiateViewControllerWithIdentifier("main") as! ViewController
//        mainViewController.userLocationButton.setTitle(selectCity, forState: UIControlState.Normal)
//        self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Done" {
            flag = false
            for i in 0...items.count - 1 {
                let province:String = items[i] as! String
                let cityArray = cityDictionary![province]! as! NSArray
                for j in 0...cityArray.count - 1 {
                    let cityKey = cityArray[j] as? String
                    if (cityKey == inputCityName.text) {
                        flag = true
                        self.delegate?.cityDidSelected(inputCityName.text!)
                    }
                }
            }
            if (flag == false) {
                let alertController = UIAlertController(title: "系统提示",
                                                        message: "该城市不支持查询", preferredStyle: .Alert)
                self.presentViewController(alertController, animated: true, completion: nil)
            } 
            self.delegate?.cityFlag(flag)
        }
    }
    
}