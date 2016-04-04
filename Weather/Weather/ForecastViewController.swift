//
//  ForecastViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/3/27.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController, TemperatureViewDelegate {
    
    let scroll = UIScrollView();
    var currentHeight: CGFloat = 0
    
    var nightFlag: Bool?
    var cityDailyForecast = [WeatherData.DailyForecast()]
    
    let LABEL_WIDTH: CGFloat = 60
    let LABEL_HEIGHT: CGFloat = 20
    
    override func viewDidLoad() {
        if (nightFlag == true) {
            //self.view.backgroundColor = UIColor.darkGrayColor()
        }
        showDate()
    }
    
    func setScroll() {
        // set the size of Scrollview
        scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        // content size
        scroll.contentSize = CGSizeMake(self.view.frame.size.width * 1.5, self.view.frame.size.width)
        // whether to support paging
        // scroll.pagingEnabled = true
        // padding
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        
        for i in 0...6 {
            let forecast = cityDailyForecast[i]
            
            let label = UILabel(frame: CGRectMake(CGFloat(i + 1) * LABEL_WIDTH, 0, LABEL_WIDTH, LABEL_HEIGHT))
            label.text = (forecast.date! as NSString).substringFromIndex(5)
            if (nightFlag == true) {
                label.textColor = UIColor.whiteColor()
            }
            scroll.addSubview(label)
        }
    }
    
    func normalization(array: [Int]) -> [CGFloat] {
        var result = [CGFloat]()
        let min = array.minElement()
        let max = array.maxElement()
        for i in 0...array.count - 1 {
            result.append(CGFloat(array[i] - min!) / CGFloat(max! - min!))
        }
        return result
    }
    
    let SR = true
    let SS = false
    
    func showAstroData(srFlag: Bool) {
        currentHeight += LABEL_HEIGHT
        let title = UILabel(frame: CGRectMake(0, currentHeight, LABEL_WIDTH, LABEL_HEIGHT))
        title.text = srFlag ? "日出" : "日落"
        title.textColor = UIColor.redColor()
        title.textAlignment = NSTextAlignment.Center
        title.layer.cornerRadius = 10
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.redColor().CGColor
        scroll.addSubview(title)
        
        var array = [Int]()
        for i in 0...6 {
            let forecast = cityDailyForecast[i]
            let sr = srFlag ? forecast.astro?.sr : forecast.astro?.ss
            let time = sr! as NSString
            let hour = time.substringWithRange(NSMakeRange(0, 2))
            let minute = time.substringWithRange(NSMakeRange(3, 2))
            let h = Int(hour)!
            let m = Int(minute)!
            let srTime = h * 60 + m
            array.append(srTime)
        }
        
        var green = normalization(array)
        
        for i in 0...6 {
            let forecast = cityDailyForecast[i]
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
            blurView.frame = CGRectMake(CGFloat(i + 1) * LABEL_WIDTH, currentHeight, LABEL_WIDTH, LABEL_HEIGHT)
            blurView.backgroundColor = srFlag ? UIColor(red: 1.0, green: green[i], blue: 0.0, alpha: 1.0) :
            UIColor(red: 0.0, green: 0.0, blue: green[i], alpha: 1.0)
            
            let label = UILabel(frame: CGRectMake(CGFloat(i + 1) * LABEL_WIDTH, currentHeight, LABEL_WIDTH, LABEL_HEIGHT))
            label.text = srFlag ? forecast.astro?.sr : forecast.astro?.ss
            scroll.addSubview(blurView)
            scroll.addSubview(label)
        }
    }
    
    func showWeatherConditionData(dayFlag: Bool) {
        currentHeight += dayFlag ? LABEL_HEIGHT : LABEL_WIDTH
        let title = UILabel(frame: CGRectMake(0, currentHeight, LABEL_WIDTH, LABEL_WIDTH))
        title.text = dayFlag ? "白天" + "\n天气" : "夜间" + "\n天气"
        title.numberOfLines = 0
        title.textColor = UIColor.orangeColor()
        title.textAlignment = NSTextAlignment.Center
        title.layer.cornerRadius = 10
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.orangeColor().CGColor
        
        scroll.addSubview(title)
        
        for i in 0...6 {
            let forecast = cityDailyForecast[i]
            let imageView = UIImageView(frame: CGRectMake(CGFloat(i + 1) * LABEL_WIDTH, currentHeight, LABEL_WIDTH, LABEL_WIDTH))
            let id = dayFlag ? (forecast.cond?.codeD)! : (forecast.cond?.codeN)!
            imageView.image = UIImage(named: "\(id)")
            scroll.addSubview(imageView)
        }
    }
    
    func showHumidityData() {
        currentHeight += LABEL_WIDTH
        let title = UILabel(frame: CGRectMake(0, currentHeight, LABEL_WIDTH, LABEL_WIDTH))
        title.text = "湿度"
        title.textColor = UIColor.yellowColor()
        title.textAlignment = NSTextAlignment.Center
        title.layer.cornerRadius = 10
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.yellowColor().CGColor
        scroll.addSubview(title)
        
        
    }
    
    func showDate() {
        setScroll()
        showAstroData(SR)
        showAstroData(SS)
        showWeatherConditionData(SR)
        showWeatherConditionData(SS)
        

        
        // precipitation
        currentHeight += LABEL_WIDTH
        var title = UILabel(frame: CGRectMake(0, currentHeight, LABEL_WIDTH, LABEL_WIDTH))
        title.text = "降水"
        title.textColor = UIColor.greenColor()
        title.textAlignment = NSTextAlignment.Center
        title.layer.cornerRadius = 10
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.greenColor().CGColor
        scroll.addSubview(title)
        
        // humidity(%) -> blue
        // precipitation(mm) -> height
        // Precipitation probability -> alpha
        
        for i in 0...6 {
            let forecast = cityDailyForecast[i]
            let hum = CGFloat(Double(forecast.hum!) / 100.0)
            let pcpn = CGFloat(forecast.pcpn!)
            let pop = CGFloat(Double(forecast.pop!) / 10.0)
            
            let subVlew = UIView(frame: CGRect(x: CGFloat(Double(i) + 1.25) * LABEL_WIDTH,
                y: currentHeight +  LABEL_WIDTH - pcpn * 2.5,
                width: LABEL_WIDTH * 0.5, height: pcpn * 2.5))
            subVlew.backgroundColor = UIColor(red: hum, green: 1.0, blue: 1.0, alpha: pop)
            scroll.addSubview(subVlew)
            
            let label = UILabel(frame: CGRect(x: CGFloat(Double(i) + 1.25) * LABEL_WIDTH,
                y: currentHeight + LABEL_WIDTH - pcpn * 2.5  - LABEL_HEIGHT * 0.5,
                width: LABEL_WIDTH, height: LABEL_HEIGHT * 0.5))
            label.text = String(pcpn) + "mm"
            label.font = UIFont(name: "HelveticaNeue", size: 10)
            label.adjustsFontSizeToFitWidth = true
            scroll.addSubview(label)

        }
        
        // temperature
        currentHeight += LABEL_WIDTH
        title = UILabel(frame: CGRectMake(0, currentHeight, LABEL_WIDTH, LABEL_WIDTH * 2))
        title.text = "温度"
        title.textColor = UIColor.cyanColor()
        title.textAlignment = NSTextAlignment.Center
        title.layer.cornerRadius = 10
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.cyanColor().CGColor
        scroll.addSubview(title)
        
        let subVlew = TemperatureView(frame: CGRect(x: LABEL_WIDTH, y: currentHeight,
            width: LABEL_WIDTH * 7, height: LABEL_WIDTH * 2))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        scroll.addSubview(subVlew)
        
        self.view.addSubview(scroll)
        
        // visitable
        currentHeight += LABEL_WIDTH * 2
        title = UILabel(frame: CGRectMake(0, currentHeight, LABEL_WIDTH, LABEL_HEIGHT))
        title.text = "可见度"
        title.textColor = UIColor.blueColor()
        title.textAlignment = NSTextAlignment.Center
        title.layer.cornerRadius = 10
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.blueColor().CGColor
        scroll.addSubview(title)
        
        var vis = [Int]()
        for i in 0...6 {
            let forecast = cityDailyForecast[i]
            vis.append(forecast.vis!)
        }
        var alpha = normalization(vis)
        
        for i in 0...6 {
            let label = UILabel(frame: CGRectMake(CGFloat(i + 1) * LABEL_WIDTH, currentHeight,
                LABEL_WIDTH, LABEL_HEIGHT))
            label.text = String(vis[i]) + "m"
            label.font = UIFont(name: "HelveticaNeue", size: CGFloat(20 - vis[i]))
            label.textAlignment = NSTextAlignment.Center
            label.adjustsFontSizeToFitWidth = true
            label.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1 - alpha[i])
            
            scroll.addSubview(label)
        }
        
        // wind
        currentHeight += LABEL_HEIGHT
        title = UILabel(frame: CGRectMake(0, currentHeight, LABEL_WIDTH, LABEL_WIDTH))
        title.text = "风速"
        title.textColor = UIColor.purpleColor()
        title.textAlignment = NSTextAlignment.Center
        title.layer.cornerRadius = 10
        title.layer.borderWidth = 2
        title.layer.borderColor = UIColor.purpleColor().CGColor
        scroll.addSubview(title)
    }
    
    func dataForTemperatureView(sender: TemperatureView) -> [WeatherData.DailyForecast] {
        return cityDailyForecast
    }
}
