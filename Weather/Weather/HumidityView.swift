//
//  HumidityView.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/4.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

protocol HumidityViewDelegate: class {
    func dataForHumidityView(sender: HumidityView) -> [WeatherData.DailyForecast]
    func timeForHumidityView(sender: HumidityView) -> Bool
}

class HumidityView: UIView {
    
    // contanst
    let LABEL_WIDTH: CGFloat = 60
    let LABEL_HEIGHT: CGFloat = 20
    let RADIUS: CGFloat = 5
    
    weak var dataSource: HumidityViewDelegate?
    
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        let cityDailyForecast = dataSource?.dataForHumidityView(self)
        let nightFlag = dataSource?.timeForHumidityView(self)
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        for i in 0...6 {
            let forecast = cityDailyForecast![i]
            let humidity = forecast.hum! / 10
            UIColor(red: 1.0, green: 1.0, blue: CGFloat(forecast.hum!) / 100, alpha: 1.0).set()
            
            for j in 1...max(1, humidity - 1) {
                for k in 1...max(1, humidity - 3) {
                    let dis = LABEL_WIDTH / CGFloat(humidity)
                    CGContextFillEllipseInRect(context, CGRectMake(LABEL_WIDTH * CGFloat(i) + dis * CGFloat(j),
                        dis * CGFloat(k), RADIUS, RADIUS))
                }
            }
            
            
            // draw string
            let color = nightFlag! ? UIColor.whiteColor() : UIColor.blackColor()
            
            let str = String(forecast.hum!) + "%"
            str.drawAtPoint(CGPointMake(LABEL_WIDTH * CGFloat(Double(i) + 0.375), LABEL_WIDTH - 15),
                            withAttributes: [NSForegroundColorAttributeName: color]);
        }
    }
}


