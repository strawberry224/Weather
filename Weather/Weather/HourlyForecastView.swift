//
//  HourlyForecastView.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/21.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

protocol HourlyForecastViewDelegate: class {
    func dataForHourlyForecastView(sender: HourlyForecastView) -> (WeatherData.HourlyForecast, WeatherData.DailyForecast)
}


class HourlyForecastView: UIView {
    
    // HourlyForecast value from deledate
    weak var dataSource: HourlyForecastViewDelegate?
    
    let WIDTH = UIScreen.mainScreen().bounds.size.width
    let HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get hourlyForecast data
        let hourlyForecast = dataSource?.dataForHourlyForecastView(self).0
        
        // get dailyForecast data
        let dailyForecast = dataSource?.dataForHourlyForecastView(self).1

        let diff = CGFloat(abs((dailyForecast?.hum)! - (hourlyForecast?.hum)!)) / CGFloat((dailyForecast?.hum)!)
        drawData(CGFloat(diff))
        
    }
    
    func drawData(val: CGFloat) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextMoveToPoint(context, 10.0, 10.0)
        CGContextAddLineToPoint(context, 20.0, 20.0)
        CGContextStrokePath(context)
    }
}