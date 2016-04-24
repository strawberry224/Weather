//
//  GeneralAQIView.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/10.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

protocol GeneralAQIViewDelegate: class {
    func dataForGeneralAQIView(sender: GeneralAQIView) -> WeatherData.CityAQI
}

import UIKit

class GeneralAQIView: UIView {
    
    // set constants value
    let WIDTH: CGFloat = UIScreen.mainScreen().bounds.size.width
    let HIGHT: CGFloat = CGFloat(UIScreen.mainScreen().bounds.size.height) / 8.0
    
    // cityAQI value from deledate
    weak var dataSource: GeneralAQIViewDelegate?
    
}

class AQIView : GeneralAQIView {
    
    // rendering code in drawRect
    override func drawRect(rect: CGRect) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // get AQI data
        let cityAQI = dataSource?.dataForGeneralAQIView(self)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // draw aqi value
        // draw background with rect, color -> red
        // set aqi value color alpha from 0 to 1
        // aqi value -> (0, 200)
        let val: CGFloat = CGFloat((cityAQI?.aqi)!)
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents:[CGFloat] = [ 1.0, 0, 0, 1.0,
                                    0.5, 0, 0, 1.0,
                                    0, 0, 0, 1.0]
        
        let locations:[CGFloat] = [0, 0.5, 1]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)
        
        // Draw a linear gradient
        // context: Graphics context
        // gradient: Gradient color
        // startPoint: Starting position
        // endCenter: The terminal point (usually the same as the starting point
        //            otherwise there will be a shift).
        // options: Drawing method, DrawsBeforeStartLocation start position before the drawing,
        //          to the end of the location is no longer drawn
        // DrawsAfterEndLocation: Start position not to draw until after the end of the point to continue filling
        CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.frame.size.width, 100),
                                    CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        // radio = val / max * 2
        let radio = min(val / 200, 1.0)
        let R = radio * HIGHT / 2
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio, WIDTH - 2 * R),
                                         y: HIGHT / 2 - R, width: R * 2, height: R * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        let r = R * 0.7
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio + R * 0.3, WIDTH - r - R),
                                         y: HIGHT / 2 - r, width: r * 2, height: r * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        // draw string
        let str = "AQI : " + String((cityAQI?.aqi)!)
        str.drawAtPoint(CGPointMake(WIDTH * radio - r, HIGHT - 15),
                        withAttributes: [NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        

    }
}


class COView : GeneralAQIView {
    override func drawRect(rect: CGRect) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // get CO data
        let cityAQI = dataSource?.dataForGeneralAQIView(self)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        // draw co value
        // draw background with rect, color -> orange
        // set co value color alpha from 0 to 1
        // co value -> (0, 60)
        let val = CGFloat((cityAQI?.co)!)
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [CGFloat] = [ 1.0, 97.0 / 255.0, 0, 1.0,
                                     0.5, 97.0 / 2 / 255.0, 0, 1.0,
                                     0, 0, 0, 1.0]
        
        let locations: [CGFloat] = [0, 0.5, 1]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)
        
        // Draw a linear gradient
        // context: Graphics context
        // gradient: Gradient color
        // startPoint: Starting position
        // endCenter: The terminal point (usually the same as the starting point
        //            otherwise there will be a shift).
        // options: Drawing method, DrawsBeforeStartLocation start position before the drawing,
        //          to the end of the location is no longer drawn
        // DrawsAfterEndLocation: Start position not to draw until after the end of the point to continue filling
        CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.frame.size.width, HIGHT * 2),
                                    CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        // radio = val / max * 2
        let radio = min(val * 10 / 60, 1.0)
        let R = radio * HIGHT / 2
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio, WIDTH - 2 * R),
                                         y: HIGHT / 2 - R, width: R * 2, height: R * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        let r = R * 0.7
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio + R * 0.3, WIDTH - r - R),
                                         y: HIGHT / 2 - r, width: r * 2, height: r * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        // draw string
        let str = "CO : " + String((cityAQI?.co)!)
        str.drawAtPoint(CGPointMake(WIDTH * radio - r, HIGHT - 15),
                        withAttributes: [NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        

    }
}


class NO2View: GeneralAQIView {
    override func drawRect(rect: CGRect) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // get NO2 data
        let cityAQI = dataSource?.dataForGeneralAQIView(self)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // draw no2 value
        // draw background with rect, color -> orange
        // set no2 value color alpha from 0 to 1
        // no2 value -> (0, 280)
        let val = CGFloat((cityAQI?.no2)!)
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [CGFloat] = [ 1.0, 1.0, 0, 1.0,
                                     1.0 / 2, 1.0 / 2, 0, 1.0,
                                     0, 0, 0, 1.0]
        
        let locations: [CGFloat] = [0, 0.5, 1]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)
        
        // Draw a linear gradient
        // context: Graphics context
        // gradient: Gradient color
        // startPoint: Starting position
        // endCenter: The terminal point (usually the same as the starting point
        //            otherwise there will be a shift).
        // options: Drawing method, DrawsBeforeStartLocation start position before the drawing,
        //          to the end of the location is no longer drawn
        // DrawsAfterEndLocation: Start position not to draw until after the end of the point to continue filling
        CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.frame.size.width, HIGHT * 2),
                                    CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        // radio = val / max * 2
        let radio = min(val / 280, 1.0)
        let R = radio * HIGHT / 2
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio, WIDTH - 2 * R),
                                         y: HIGHT / 2 - R, width: R * 2, height: R * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        let r = R * 0.7
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio + R * 0.3, WIDTH - r - R),
                                         y: HIGHT / 2 - r, width: r * 2, height: r * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        // draw string
        let str = "NO2 : " + String((cityAQI?.no2)!)
        str.drawAtPoint(CGPointMake(WIDTH * radio - r, HIGHT - 15),
                        withAttributes: [NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        
    }
}


class O3View: GeneralAQIView {
    override func drawRect(rect: CGRect) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // get O3 data
        let cityAQI = dataSource?.dataForGeneralAQIView(self)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // draw o3 value
        // draw background with rect, color -> orange
        // set o3 value color alpha from 0 to 1
        // o3 value -> (0, 265)
        let val = CGFloat((cityAQI?.o3)!)
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [CGFloat] = [ 0, 1.0, 0, 1.0,
                                     0, 1.0 / 2, 0, 1.0,
                                     0, 0, 0, 1.0]
        
        let locations: [CGFloat] = [0, 0.5, 1]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)
        
        // Draw a linear gradient
        // context: Graphics context
        // gradient: Gradient color
        // startPoint: Starting position
        // endCenter: The terminal point (usually the same as the starting point
        //            otherwise there will be a shift).
        // options: Drawing method, DrawsBeforeStartLocation start position before the drawing,
        //          to the end of the location is no longer drawn
        // DrawsAfterEndLocation: Start position not to draw until after the end of the point to continue filling
        CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.frame.size.width, HIGHT * 2),
                                    CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        // radio = val / max * 2
        let radio = min(val / 265, 1.0)
        let R = radio * HIGHT / 2
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio, WIDTH - 2 * R),
                                         y: HIGHT / 2 - R, width: R * 2, height: R * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        let r = R * 0.7
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio + R * 0.3, WIDTH - r - R),
                                         y: HIGHT / 2 - r, width: r * 2, height: r * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        // draw string
        let str = "O3 : " + String((cityAQI?.o3)!)
        str.drawAtPoint(CGPointMake(WIDTH * radio - r, HIGHT - 15),
                        withAttributes: [NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        
    }
}

class PM10View: GeneralAQIView {
    override func drawRect(rect: CGRect) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // get PM10 data
        let cityAQI = dataSource?.dataForGeneralAQIView(self)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // draw pm10 value
        // draw background with rect, color -> orange
        // set pm10 value color alpha from 0 to 1
        // pm10 value -> (0, 140)
        let val = CGFloat((cityAQI?.pm10)!)
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [CGFloat] = [ 0, 1.0, 1.0, 1.0,
                                     0, 1.0 / 2, 1.0 / 2, 1.0,
                                     0, 0, 0, 1.0]
        
        let locations: [CGFloat] = [0, 0.5, 1]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)
        
        // Draw a linear gradient
        // context: Graphics context
        // gradient: Gradient color
        // startPoint: Starting position
        // endCenter: The terminal point (usually the same as the starting point
        //            otherwise there will be a shift).
        // options: Drawing method, DrawsBeforeStartLocation start position before the drawing,
        //          to the end of the location is no longer drawn
        // DrawsAfterEndLocation: Start position not to draw until after the end of the point to continue filling
        CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.frame.size.width, HIGHT * 2),
                                    CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        // radio = val / max * 2
        let radio = min(val / 140, 1.0)
        let R = radio * HIGHT / 2
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio, WIDTH - 2 * R),
                                         y: HIGHT / 2 - R, width: R * 2, height: R * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        let r = R * 0.7
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio + R * 0.3, WIDTH - r - R),
                                         y: HIGHT / 2 - r, width: r * 2, height: r * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        // draw string
        let str = "PM10 : " + String((cityAQI?.pm10)!)
        str.drawAtPoint(CGPointMake(min(WIDTH * radio, WIDTH - 2 * R) - r, HIGHT - 15),
                        withAttributes: [NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        
    }
}


class PM25View: GeneralAQIView {
    override func drawRect(rect: CGRect) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // get PM25 data
        let cityAQI = dataSource?.dataForGeneralAQIView(self)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // draw pm25 value
        // draw background with rect, color -> orange
        // set pm25 value color alpha from 0 to 1
        // pm10 value -> (0, 150)
        let val = CGFloat((cityAQI?.pm25)!)
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [CGFloat] = [ 0, 0, 1.0, 1.0,
                                     0, 0, 1.0 / 2, 1.0,
                                     0, 0, 0, 1.0]
        
        let locations: [CGFloat] = [0, 0.4, 1]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)
        
        // Draw a linear gradient
        // context: Graphics context
        // gradient: Gradient color
        // startPoint: Starting position
        // endCenter: The terminal point (usually the same as the starting point
        //            otherwise there will be a shift).
        // options: Drawing method, DrawsBeforeStartLocation start position before the drawing,
        //          to the end of the location is no longer drawn
        // DrawsAfterEndLocation: Start position not to draw until after the end of the point to continue filling
        CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.frame.size.width, HIGHT * 2),
                                    CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        // radio = val / max * 2
        let radio = min(val / 150, 1.0)
        let R = radio * HIGHT / 2
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio, WIDTH - 2 * R),
                                         y: HIGHT / 2 - R, width: R * 2, height: R * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        let r = R * 0.7
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio + R * 0.3, WIDTH - r - R), 
                                         y: HIGHT / 2 - r, width: r * 2, height: r * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        // draw string
        let str = "PM25 : " + String((cityAQI?.pm25)!)
        str.drawAtPoint(CGPointMake(WIDTH * radio - r, HIGHT - 15),
                        withAttributes: [NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        
    }
}


class SO2View: GeneralAQIView {
    override func drawRect(rect: CGRect) {
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // get SO2 data
        let cityAQI = dataSource?.dataForGeneralAQIView(self)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // draw so2 value
        // draw background with rect, color -> orange
        // set so2 value color alpha from 0 to 1
        // so2 value -> (0, 800)
        let val = CGFloat((cityAQI?.so2)!)
        
        // Specified gradient color
        // space: color space
        // components: Color array, note that due to the specified RGB color space,
        // then the four array elements are represented by a color (red, green, blue, alpha),
        // If there are three colors, this array has 4*3 elements,
        // locations: Where the color is located (range 0~1),
        // the number of the array is not less than the number of colors in the components.
        // count: Number of gradient, equal to the number of locations
        let compoents: [CGFloat] = [ 1.0, 0, 1.0, 1.0,
                                     1.0 / 2, 0, 1.0 / 2, 1.0,
                                     0, 0, 0, 1.0]
        
        let locations: [CGFloat] = [0, 0.4, 1]
        let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)
        
        // Draw a linear gradient
        // context: Graphics context
        // gradient: Gradient color
        // startPoint: Starting position
        // endCenter: The terminal point (usually the same as the starting point
        //            otherwise there will be a shift).
        // options: Drawing method, DrawsBeforeStartLocation start position before the drawing,
        //          to the end of the location is no longer drawn
        // DrawsAfterEndLocation: Start position not to draw until after the end of the point to continue filling
        CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(self.frame.size.width, HIGHT * 2),
                                    CGGradientDrawingOptions.DrawsAfterEndLocation)
        
        // radio = val / max * 2
        let radio = min(val * 10 / 800, 1.0)
        let R = radio * HIGHT / 2
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio, WIDTH - 2 * R),
                                         y: HIGHT / 2 - R, width: R * 2, height: R * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        let r = R * 0.7
        UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9).set()
        CGContextAddEllipseInRect(context,
                                  CGRect(x: min(WIDTH * radio + R * 0.3, WIDTH - r - R),
                                         y: HIGHT / 2 - r, width: r * 2, height: r * 2))
        CGContextDrawPath(context, CGPathDrawingMode.FillStroke)
        
        // draw string
        let str = "SO2 : " + String((cityAQI?.so2)!)
        str.drawAtPoint(CGPointMake(WIDTH * radio - r, HIGHT - 15),
                        withAttributes: [NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        
    }
}


