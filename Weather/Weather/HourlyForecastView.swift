//
//  HourlyForecastView.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/21.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

protocol HourlyForecastViewDelegate: class {
    func dataForHourlyForecastView(sender: HourlyForecastView) -> ([WeatherData.HourlyForecast], WeatherData.Now)
    func timeForHourlyForecastView(sender: HourlyForecastView) -> Bool
}


class HourlyForecastView: UIView {
    
    // HourlyForecast value from deledate
    weak var dataSource: HourlyForecastViewDelegate?
    
    func drawData(hourlyForecast: [CGFloat], color: UIColor) {
        
        let WIDTH = UIScreen.mainScreen().bounds.size.width / CGFloat(hourlyForecast.count - 1)
        let HEIGHT = UIScreen.mainScreen().bounds.size.height
        
        let bezierPath = UIBezierPath()
        
        // draw Lower left corner point
        bezierPath.moveToPoint(CGPointMake(0, HEIGHT))
        
        // set string's color by nightFlag
        let strColor = dataSource?.timeForHourlyForecastView(self) == true ? UIColor.whiteColor() : UIColor.blackColor()
        for i in 0...hourlyForecast.count - 1 {
            bezierPath.addLineToPoint(CGPointMake(CGFloat(i) * WIDTH, HEIGHT - hourlyForecast[i]))
            print(i)
            let str = String(hourlyForecast[i])
            str.drawAtPoint(CGPointMake(CGFloat(i) * WIDTH, HEIGHT - hourlyForecast[i]),
                             withAttributes: [NSForegroundColorAttributeName: strColor]);

        }
        bezierPath.addLineToPoint(CGPointMake(CGFloat(hourlyForecast.count - 1) * WIDTH, HEIGHT))
        
        // Make path close, end drawing
        bezierPath.closePath()
        
        // Set colors and draw them
        color.setFill()
        UIColor.whiteColor().setStroke()
        
        bezierPath.fill()
        bezierPath.stroke()
        
    }
}


class HourlyHumView: HourlyForecastView {
    
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get hourlyForecast data
        let hourlyForecast = dataSource?.dataForHourlyForecastView(self).0
        
        // get dailyForecast data
        let now = dataSource?.dataForHourlyForecastView(self).1
        
        var array = [CGFloat]()
        
        array.append(CGFloat((now?.hum)!))
        for i in 0...(hourlyForecast?.count)! - 1 {
            array.append(CGFloat(hourlyForecast![i].hum!))
        }
        
        // get random color value
        let red: CGFloat = CGFloat(arc4random() % 255) / CGFloat(255)
        let green: CGFloat = CGFloat(arc4random() % 255) / CGFloat(255)
        let blue: CGFloat = CGFloat(arc4random() % 255) / CGFloat(255)

        drawData(array, color: UIColor(red: red, green: green, blue: blue, alpha: 0.5))
    }
}