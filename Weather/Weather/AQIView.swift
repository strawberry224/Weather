//
//  AQIView.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/10.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

protocol AQIViewDelegate: class {
    func dataForAQIView(sender: AQIView) -> WeatherData.CityAQI
}

import UIKit

class AQIView: UIView {
    
    // set constants value
    let WIDTH: CGFloat = 200
    let HIGHT: CGFloat = UIScreen.mainScreen().bounds.size.height
    
    // cityAQI value from deledate
    weak var dataSource: AQIViewDelegate?
    
    override func drawRect(rect: CGRect) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        let cityAQI = dataSource?.dataForAQIView(self)
        
        // draw aqi value
        // draw background with rect, color -> (red, green)
        // set AQI value color from red to green
        let val: CGFloat = CGFloat(min((cityAQI?.aqi)!, 255))
        UIColor(red: 1.0, green: 0, blue: 0, alpha: val / 255).set()
        UIRectFill(CGRectMake(0, 0, WIDTH, HIGHT))
        
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
        CGContextAddEllipseInRect(context, CGRect(x: WIDTH / 2 - val / 2, y: val - val / 2, width: val, height: val))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9).set()
        CGContextAddEllipseInRect(context, CGRect(x: WIDTH / 2 - val / 4, y: val - val / 4, width: val / 2, height: val / 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
    }
}
