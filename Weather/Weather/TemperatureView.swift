//
//  TemperatureView.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/3.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

protocol TemperatureViewDelegate: class {
    func dataForTemperatureView(sender: TemperatureView) -> [WeatherData.DailyForecast]
    func timeForTemperatureView(sender: TemperatureView) -> Bool
}

class TemperatureView: UIView {
    
    // set constants value 
    let LABEL_WIDTH: CGFloat = 60
    let LABEL_HEIGHT: CGFloat = 20
    let RADIUS: CGFloat = 5
    
    weak var dataSource: TemperatureViewDelegate?
    
    func drawTemperature(cityDailyForecast: [WeatherData.DailyForecast], flag: Bool) {
        
        var max = [Int]()
        
        // normalization
        for i in 0...6 {
            let element = flag ? (cityDailyForecast[i].tmp?.max)! : (cityDailyForecast[i].tmp?.min)!
            max.append(element)
        }
        var high = normalization(max)
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        let color = flag ? UIColor.redColor() : UIColor.blueColor()
        let offset: CGFloat = flag ? 2 : 4

        for i in 0...6 {
            // draw point
            color.set()
            CGContextFillEllipseInRect(context, CGRectMake(CGFloat(Double(i) + 0.5) * LABEL_WIDTH,
                (offset - CGFloat(high[i])) * LABEL_HEIGHT,
                RADIUS, RADIUS))
            
            // draw string
            let nightFlag = dataSource?.timeForTemperatureView(self)
            let strColor = nightFlag! ? UIColor.whiteColor() : UIColor.blackColor()
            let str = String(max[i])
            str.drawAtPoint(CGPointMake(CGFloat(Double(i) + 0.5) * LABEL_WIDTH, (offset - CGFloat(high[i])) * LABEL_HEIGHT + RADIUS),
                            withAttributes: [NSForegroundColorAttributeName: strColor]);
            
            // draw line
            if (i < 6) {
                // Set brush width
                CGContextSetLineWidth(context, 2)
                color.set()
                CGContextMoveToPoint(context, CGFloat(Double(i) + 0.5) * LABEL_WIDTH,
                                     (offset - CGFloat(high[i])) * LABEL_HEIGHT + RADIUS / 2);
                CGContextAddLineToPoint(context, CGFloat(Double(i + 1) + 0.5) * LABEL_WIDTH,
                                        (offset - CGFloat(high[i + 1])) * LABEL_HEIGHT + RADIUS / 2);
                CGContextStrokePath(context)
            }
        }
        setNeedsDisplay()
    }
    
    
    override func drawRect(rect: CGRect) {
        let cityDailyForecast = dataSource?.dataForTemperatureView(self)
        drawTemperature(cityDailyForecast!, flag: true)
        drawTemperature(cityDailyForecast!, flag: false)
    }
}