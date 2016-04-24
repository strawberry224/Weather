//
//  TodayView.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/22.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

protocol TodayViewDelegate: class {
    func dataForTodayView(sender: TodayView) -> (WeatherData.Now)
    func timeForTodayView(sender: TodayView) -> Bool
}


class TodayView: UIView {
    
    // HourlyForecast value from deledate
    weak var dataSource: TodayViewDelegate?
    
    let WIDTH = UIScreen.mainScreen().bounds.size.width
    let HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get now weather data
        let now = dataSource?.dataForTodayView(self)
        let flag = dataSource?.timeForTodayView(self)
        
        // Make sure that the data is between 0 and 0.5
        var val = min(CGFloat(abs((now?.cond!.code)! - 100)) / 100, 0.5)
        drawData(val, valOrigin: CGFloat((now?.cond!.code)!), name: (now?.cond?.txt)!, flag: flag!)
        
        // Make sure that the data is between 0 and 0.5
        val = min(CGFloat(abs((now?.tmp)! - 26)) / 26, 0.5)
        drawData(val, valOrigin: CGFloat((now?.tmp)!), name: "温度:" + String(CGFloat((now?.tmp)!)), flag: flag!)
        
        // Make sure that the data is between 0 and 0.5
        val = min(CGFloat(abs((now?.hum)! - 50)) / 50, 0.5)
        drawData(val, valOrigin: CGFloat((now?.hum)!), name: "湿度:" + String(CGFloat((now?.hum)!)) + "%", flag: flag!)
        
        // Make sure that the data is between 0 and 0.5
        val = min(CGFloat(abs((now?.pcpn)!)) / 500, 0.5)
        drawData(val, valOrigin: CGFloat((now?.pcpn)!), name: "降水:" + String(CGFloat((now?.pcpn)!)) + "mm", flag: flag!)
        
        // Make sure that the data is between 0 and 0.5
        val = min(CGFloat(abs((now?.pres)! - 1000)) / 1000, 0.5)
        drawData(val, valOrigin: CGFloat((now?.pres)!), name: "气压:" + String(CGFloat((now?.pres)!)), flag: flag!)
        
        // Make sure that the data is between 0 and 0.5
        val = min(CGFloat(abs((now?.vis)! - 10)) / 10, 0.5)
        drawData(val, valOrigin: CGFloat((now?.vis)!), name: "可见度:" + String(CGFloat((now?.vis)!)) + "km", flag: flag!)

        // Make sure that the data is between 0 and 0.5
        val = min(CGFloat(abs((now?.wind!.spd)! - 10)) / 10, 0.5)
        drawData(val, valOrigin: CGFloat((now?.wind!.spd)!), name: "风速:" + String(CGFloat((now?.wind!.spd)!)) + "kmph", flag: flag!)

    }
    
    func drawData(val: CGFloat, valOrigin: CGFloat, name: String, flag: Bool) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // get random color value
        let red: CGFloat = CGFloat(arc4random() % 255) / CGFloat(255)
        let green: CGFloat = CGFloat(arc4random() % 255) / CGFloat(255)
        let blue: CGFloat = CGFloat(arc4random() % 255) / CGFloat(255)
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents:[CGFloat] = [ red, green, blue, 1.0,
                                    red, green, blue, val,
                                    red, green, blue, 0]
        
        let locations:[CGFloat] = [0, val * 1.5, 1]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)

        let radius: CGFloat = val * WIDTH / 2
        
        // get random position value
        var max = UInt32(WIDTH - radius)
        var min = UInt32(radius)
        
        let x: CGFloat = CGFloat(arc4random_uniform(max - min) + min)
        
        max = UInt32(HEIGHT - radius)
        min = UInt32(radius)
        
        let y: CGFloat = CGFloat(arc4random_uniform(max - min) + min)
        
        // Draw a linear gradient
        // context: Graphics context
        // gradient: Gradient color
        // startPoint: Starting position
        // startRadius: Start radius (usually 0, otherwise there is no fill in this radius)
        // endCenter: The terminal point (usually the same as the starting point
        //            otherwise there will be a shift).
        // endRadius: End point radius (that is, the diffusion length of the gradient)
        // options: Drawing method, DrawsBeforeStartLocation start position before the drawing,
        //          to the end of the location is no longer drawn
        // DrawsAfterEndLocation: Start position not to draw until after the end of the point to continue filling
        CGContextDrawRadialGradient(context, gradient,
                                    CGPointMake(x, y), 0,
                                    CGPointMake(x, y), radius,
                                    CGGradientDrawingOptions.DrawsBeforeStartLocation)
        
        let color = flag ? UIColor.lightTextColor() : UIColor.darkTextColor()
        name.drawAtPoint(CGPointMake(x - radius, y),
                        withAttributes: [NSFontAttributeName:UIFont.boldSystemFontOfSize(val * 70),
                                         NSForegroundColorAttributeName: color]);
    }
}