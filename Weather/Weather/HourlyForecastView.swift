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
    
    let WIDTH = UIScreen.mainScreen().bounds.size.width
    let HEIGHT = UIScreen.mainScreen().bounds.size.height
    
    func drawData(value: [CGFloat], rawValue: [String], compoents: [UIColor]) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // set radius
        var radius: CGFloat = WIDTH
        for i in 0...compoents.count - 1 {

            // change raduis
            radius -= 50
            compoents[i].set()
            CGContextAddEllipseInRect(context,
                                      CGRect(x: WIDTH / 2 - radius / 2, y: HEIGHT / 2 - radius / 2, width: radius, height: radius))
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)

        }
        
        radius = (WIDTH - 20) / 2
        for i in 0...7 {
            let x = WIDTH / 2 + radius * cos(CGFloat(M_PI) / 4 * CGFloat(i - 2) + CGFloat(M_PI) / 6)
            let y = HEIGHT / 2 + radius * sin(CGFloat(M_PI) / 4 * CGFloat(i - 2) + CGFloat(M_PI) / 6)
            
            // draw string
            let str = String(i * 3 + 1)
            str.drawAtPoint(CGPointMake(x, y),
                            withAttributes: [NSForegroundColorAttributeName: UIColor.blackColor()]);

        }
        
        for j in 0...value.count - 1 {
            let i = value.count - 1 - j
            
            UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
            
            // Drawing starting point
            CGContextMoveToPoint(context, WIDTH / 2, HEIGHT / 2)
            
            radius = (WIDTH - 50) / 2 * value[i]
            let x1 = WIDTH / 2 + radius * cos(CGFloat(M_PI) / 4 * CGFloat(5 - j) + CGFloat(M_PI) / 6)
            let y1 = HEIGHT / 2 + radius * sin(CGFloat(M_PI) / 4 * CGFloat(5 - j) + CGFloat(M_PI) / 6)

            // from the starting point to this point
            CGContextAddLineToPoint(context, x1, y1)
            
            var x2 = x1
            var y2 = y1
        
            if (i == value.count - 1 && value.count < 8) {
                radius = radius * 1.0
            } else {
                radius = (WIDTH - 50) / 2 * value[(i + 1) % value.count]
            }
            
            x2 = WIDTH / 2 + radius * cos(CGFloat(M_PI) / 4 * CGFloat(5 - j + 1) + CGFloat(M_PI) / 6)
            y2 = HEIGHT / 2 + radius * sin(CGFloat(M_PI) / 4 * CGFloat(5 - j + 1) + CGFloat(M_PI) / 6)
            
            CGContextAddLineToPoint(context, x2, y2)
            
            // Closed path
            CGContextClosePath(context)
            UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).setStroke()
            UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7).setFill()
            
            // Drawing path
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
            
            // draw string
            let str = String(rawValue[i])
            let minX = (x1 + x2) / 2
            let minY = (y1 + y2) / 2
            str.drawAtPoint(CGPointMake(minX, minY),
                            withAttributes: [NSForegroundColorAttributeName: UIColor.blackColor()]);
        }
    }
}


class HourlyHumView: HourlyForecastView {
    
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get hourlyForecast data
        let hourlyForecast = dataSource?.dataForHourlyForecastView(self).0
        
        // get dailyForecast data
        _ = dataSource?.dataForHourlyForecastView(self).1
        
        var array = [CGFloat]()
        var rawValue = [String]()
        
        for i in 0...(hourlyForecast?.count)! - 1 {
            rawValue.append(String(hourlyForecast![i].hum!) + "%")
            array.append(CGFloat(hourlyForecast![i].hum!) / 100.0)
        }
        
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [UIColor] = [ UIColor(red: 31 / 255,  green: 71 / 255, blue: 173 / 255,  alpha: 1.0),
                                     UIColor(red: 64 / 255,  green: 149 / 255, blue: 214 / 255, alpha: 1.0),
                                     UIColor(red: 57 / 255,   green: 204 / 255, blue: 230 / 255, alpha: 1.0),
                                     UIColor(red: 227 / 255,   green: 248 / 255, blue: 255 / 255, alpha: 1.0),
                                     UIColor(red: 255 / 255,  green: 255 / 255, blue: 255 / 255,  alpha: 1.0)]

        
        drawData(array, rawValue: rawValue, compoents: compoents)
    }
}

class HourlyPopView: HourlyForecastView {
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get hourlyForecast data
        let hourlyForecast = dataSource?.dataForHourlyForecastView(self).0
        
        // get dailyForecast data
        _ = dataSource?.dataForHourlyForecastView(self).1
        
        var array = [CGFloat]()
        var rawValue = [String]()
        
        for i in 0...(hourlyForecast?.count)! - 1 {
            rawValue.append(String(hourlyForecast![i].pop!) + "%")
            array.append(CGFloat(hourlyForecast![i].pop!) / 100.0)
        }
        
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [UIColor] = [ UIColor(red: 70 / 255,  green: 159 / 255, blue: 170 / 255,  alpha: 1.0),
                                     UIColor(red: 74 / 255,   green: 186 / 255, blue: 196 / 255, alpha: 1.0),
                                     UIColor(red: 234 / 255,   green: 225 / 255, blue: 206 / 255, alpha: 1.0),
                                     UIColor(red: 234 / 255,  green: 225 / 255, blue: 206 / 255, alpha: 1.0),
                                     UIColor(red: 249 / 255,  green: 246 / 255, blue: 239 / 255,  alpha: 1.0)]
        
        
        drawData(array, rawValue: rawValue, compoents: compoents)
    }
}

class HourlyPresView: HourlyForecastView {
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get hourlyForecast data
        let hourlyForecast = dataSource?.dataForHourlyForecastView(self).0
        
        // get dailyForecast data
        _ = dataSource?.dataForHourlyForecastView(self).1
        
        var array = [CGFloat]()
        var rawValue = [String]()
        
        for i in 0...(hourlyForecast?.count)! - 1 {
            rawValue.append(String(hourlyForecast![i].pres!))
            array.append(min(CGFloat(hourlyForecast![i].pres!) / 1100.0, 1.0))
        }
        
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [UIColor] = [ UIColor(red: 72 / 255,  green: 72 / 255, blue: 72 / 255,  alpha: 1.0),
                                     UIColor(red: 96 / 255,   green: 96 / 255, blue: 96 / 255, alpha: 1.0),
                                     UIColor(red: 192 / 255,   green: 216 / 255, blue: 216 / 255, alpha: 1.0),
                                     UIColor(red: 216 / 255,  green: 240 / 255, blue: 240 / 255, alpha: 1.0),
                                     UIColor(red: 240 / 255,  green: 240 / 255, blue: 240 / 255,  alpha: 1.0)]
        
        
        drawData(array, rawValue: rawValue, compoents: compoents)
    }
}

class HourlyTmpView: HourlyForecastView {
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get hourlyForecast data
        let hourlyForecast = dataSource?.dataForHourlyForecastView(self).0
        
        // get dailyForecast data
        _ = dataSource?.dataForHourlyForecastView(self).1
        
        var array = [CGFloat]()
        var rawValue = [String]()
        
        for i in 0...(hourlyForecast?.count)! - 1 {
            rawValue.append(String(hourlyForecast![i].tmp!) + "℃")
            array.append(min(CGFloat(max(hourlyForecast![i].tmp! + 10, 0)) / 50, 1.0))
        }
        
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [UIColor] = [ UIColor(red: 0 / 255,  green: 146 / 255, blue: 199 / 255,  alpha: 1.0),
                                     UIColor(red: 159 / 255,  green: 224 / 255, blue: 246 / 255, alpha: 1.0),
                                     UIColor(red: 243 / 255,   green: 229 / 255, blue: 154 / 255, alpha: 1.0),
                                     UIColor(red: 243 / 255,   green: 181 / 255, blue: 155 / 255, alpha: 1.0),
                                     UIColor(red: 242 / 255,  green: 156 / 255, blue: 156 / 255,  alpha: 1.0)]
        
        
        drawData(array, rawValue: rawValue, compoents: compoents)
    }
}

class HourlyWindView: HourlyForecastView {
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get hourlyForecast data
        let hourlyForecast = dataSource?.dataForHourlyForecastView(self).0
        
        // get dailyForecast data
        _ = dataSource?.dataForHourlyForecastView(self).1
        
        var array = [CGFloat]()
        var rawValue = [String]()
        
        for i in 0...(hourlyForecast?.count)! - 1 {
            rawValue.append(String(CGFloat((hourlyForecast![i].wind?.spd!)!)) + "kmph")
            array.append(min(CGFloat((hourlyForecast![i].wind?.spd!)!) / 50, 1.0))
        }
        
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [UIColor] = [ UIColor(red: 100 / 255,  green: 120 / 255, blue: 111 / 255,  alpha: 1.0),
                                     UIColor(red: 120 / 255,   green: 200 / 255, blue: 187 / 255, alpha: 1.0),
                                     UIColor(red: 120 / 255,   green: 200 / 255, blue: 187 / 255, alpha: 1.0),
                                     UIColor(red: 122 / 255,  green: 207 / 255, blue: 200 / 255, alpha: 1.0),
                                     UIColor(red: 183 / 255,  green: 218 / 255, blue: 214 / 255,  alpha: 1.0)]
        
        
        drawData(array, rawValue: rawValue, compoents: compoents)
    }
}