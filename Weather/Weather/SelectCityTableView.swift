//
//  SelectCityTableView.swift
//  Weather
//
//  Created by Shen Lijia on 16/2/18.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class SelectCityTableView: UITableViewController {
    
    var items: [String] = ["Hangzhou", "tongxiang", "shanghai"]
    
    var urlString = "https://api.heweather.com/x3/citylist?search=allchina&key=3cf1f802ec8f4fb8a1b40aebfabed705"
    
    func requestUrl(urlString: String){
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        let session = NSURLSession.sharedSession()
        request.timeoutInterval = 6
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) -> Void in
            let result = response as! NSHTTPURLResponse
            print(result.statusCode)
            if let _ = error{
                print("请求失败")
            }
            if let _ = data {
                //self.testJson(data!)
                let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                if let cityInfoArray = jsonObject.objectForKey("city_info") as? NSArray {
                    self.items.removeAll()
                    for index in 0...cityInfoArray.count - 1 {
                        if let cityInfo = cityInfoArray[index] as? NSDictionary {
                            self.items.append(self.getCityList.getCityList(cityInfo).city!)
                            
                        }
                    }
                }
            }
        })
        
        task.resume()
    }
    
    var getCityList = GetCityList()
    
    func testJson(data: NSData) {
        
        //dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            if let cityInfoArray = jsonObject.objectForKey("city_info") as? NSArray {
                self.items.removeAll()
                for index in 0...cityInfoArray.count - 1 {
                    if let cityInfo = cityInfoArray[index] as? NSDictionary {
                        self.items.append(self.getCityList.getCityList(cityInfo).city!)
                        
                    }
                }
            }
        //})
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //requestUrl(urlString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDelegate & Datasource
    
    // Is specified in the UITableView how many section
    // section partition
    // a section will contain more than Cell
    // there is only one section
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Is specified in each of the section which has a number of Cell.
    // Because we have only one section
    // how many cities have the number of optional Cell
    // This is depending on the situation.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    // Initialize every Cell.
    // A Cell looks like it is determined by this method.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    // Is the method of selecting an Cell after execution.
    // When the user selects a cell, we need to know which one it is
    // and the cell of the city's name sent to the main interface used to access the city's weather data.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
}
