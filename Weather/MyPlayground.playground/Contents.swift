//: Playground - noun: a place where people can play

import UIKit

var httpUrl = "http://apis.baidu.com/heweather/weather/free"
var httpArg = "city=shanghai"

let request = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpArg)!)
let session = NSURLSession.sharedSession()
request.timeoutInterval = 6
request.HTTPMethod = "GET"
request.addValue("616e8a401061a1108d387543235f3159", forHTTPHeaderField: "apikey")

session.dataTaskWithRequest(request) { (data, response, error) -> Void in
    let res = response as! NSHTTPURLResponse
    print(res.statusCode)
    if let _ = error{
        print("请求失败")
    }
    if let d = data {
        let content = NSString(data: d, encoding: NSUTF8StringEncoding)
        print(content)
    }
}

//    func testJson(data: NSData) {
//        print("!!!")
////        if !NSJSONSerialization.isValidJSONObject(data) {
////            print("不是合法的json对象")
////            return
////        }
//        let json: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
//        let weatherInfo = json.objectForKey("aqi")
//        print("\(weatherInfo)")
//    }
