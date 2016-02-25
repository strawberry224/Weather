//
//  CityListData.swift
//  Weather
//
//  Created by Shen Lijia on 16/2/19.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import Foundation

class CityListData: NSObject {
    
    var city: String?
    var prov: String?
    
    var items: [String?] = ["hangzhou"]
    
    var getCityList = GetCityList()
    
    override init() {
        super.init()
        var urlString = "https://api.heweather.com/x3/citylist?search=allchina&key=3cf1f802ec8f4fb8a1b40aebfabed705"
        
        func requestUrl(urlString: String){
            
            let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
            let session = NSURLSession.sharedSession()
            request.timeoutInterval = 6
            request.HTTPMethod = "GET"
            
            let task = session.dataTaskWithRequest(request, completionHandler: {
                (data, response, error) -> Void in
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
                                print("<string>\(self.items[index])</string>")
                            }
                        }
                    }
                }
            })
            
            task.resume()
        }

    }
}