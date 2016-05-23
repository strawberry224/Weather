//
//  HourlyForecastViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/20.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class HourlyForecastViewController: UIViewController, HourlyForecastViewDelegate {
    
    let scroll = UIScrollView();
    
    // According to nightFlag to change the background color
    var nightFlag: Bool?
    var hourlyForecast =  [WeatherData.HourlyForecast()]
    var now =  WeatherData.Now()

    
    override func viewDidLoad() {
        //if (nightFlag == true) {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "hour_bg")!)
        //}
        
        setScroll()
        self.view.addSubview(scroll)
    }
    
    func setScroll() {
        
        // set the size of Scrollview
        scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        // content size
        scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 5)
        
        // whether to support paging
        // scroll.pagingEnabled = true
        // padding
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        
        // draw AQI data
        var subVlew: HourlyForecastView
        var title = UILabel(frame: CGRectMake(0, 15, self.view.frame.size.width, 20))
        title.text = "相对湿度"
        title.textColor = UIColor.darkTextColor()
        title.textAlignment = NSTextAlignment.Center
        scroll.addSubview(title)

        subVlew = HourlyHumView(frame: CGRect(x: 0, y: -50,
            width: self.view.frame.size.width, height: self.view.frame.size.height))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        scroll.addSubview(subVlew)
        
        title = UILabel(frame: CGRectMake(0, self.view.frame.size.height + 70, self.view.frame.size.width, 20))
        title.text = "降水概率"
        title.textColor = UIColor.darkTextColor()
        title.textAlignment = NSTextAlignment.Center
        scroll.addSubview(title)

        
        subVlew = HourlyPopView(frame: CGRect(x: 0, y: self.view.frame.size.height,
            width: self.view.frame.size.width, height: self.view.frame.size.height))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        scroll.addSubview(subVlew)
        
        title = UILabel(frame: CGRectMake(0, self.view.frame.size.height * 2 + 70, self.view.frame.size.width, 20))
        title.text = "气压"
        title.textColor = UIColor.darkTextColor()
        title.textAlignment = NSTextAlignment.Center
        scroll.addSubview(title)
        
        
        subVlew = HourlyPresView(frame: CGRect(x: 0, y: self.view.frame.size.height * 2,
            width: self.view.frame.size.width, height: self.view.frame.size.height))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        scroll.addSubview(subVlew)
        
        title = UILabel(frame: CGRectMake(0, self.view.frame.size.height * 3 + 70, self.view.frame.size.width, 20))
        title.text = "温度"
        title.textColor = UIColor.darkTextColor()
        title.textAlignment = NSTextAlignment.Center
        scroll.addSubview(title)
        
        
        subVlew = HourlyTmpView(frame: CGRect(x: 0, y: self.view.frame.size.height * 3,
            width: self.view.frame.size.width, height: self.view.frame.size.height))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        scroll.addSubview(subVlew)
        
        title = UILabel(frame: CGRectMake(0, self.view.frame.size.height * 4 + 70, self.view.frame.size.width, 20))
        title.text = "风速"
        title.textColor = UIColor.darkTextColor()
        title.textAlignment = NSTextAlignment.Center
        scroll.addSubview(title)
        
        
        subVlew = HourlyWindView(frame: CGRect(x: 0, y: self.view.frame.size.height * 4,
            width: self.view.frame.size.width, height: self.view.frame.size.height))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        scroll.addSubview(subVlew)


    }
    
    // ViewDelegate
    // HourlyForecastView
    func dataForHourlyForecastView(sender: HourlyForecastView) -> ([WeatherData.HourlyForecast], WeatherData.Now) {
        return (hourlyForecast, now)
    }
    
    func timeForHourlyForecastView(sender: HourlyForecastView) -> Bool {
        return nightFlag!
    }
}

    