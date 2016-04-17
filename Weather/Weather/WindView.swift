//
//  WindViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/5.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

protocol WindViewDelegate: class {
    func dataForWindView(sender: WindView) -> [WeatherData.DailyForecast]
    func timeForWindView(sender: WindView) -> Bool
}

// Radial gradient rendering
class WindView: UIView {
    
    // contanst
    let LABEL_WIDTH: CGFloat = 60
    let LABEL_HEIGHT: CGFloat = 20
    let RADIUS: CGFloat = 5
    
    weak var dataSource: WindViewDelegate?
    
    override func drawRect(rect: CGRect) {
        
        // get wind value form delegate
        let cityDailyForecast = dataSource?.dataForWindView(self)
        
        // get brush context
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!
        // antialiasing settings
        CGContextSetAllowsAntialiasing(context, true)
        
        // use RGB color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // normalization
        var spd = [Int]()
        for i in 0...6 {
            spd.append((cityDailyForecast![i].wind?.spd)!)
        }
        var blue = normalization(spd)
        
        for i in 0...6 {
        
             // Specified gradient color
             // space: color space
             // components: Color array, note that due to the specified RGB color space, 
             // then the four array elements are represented by a color (red, green, blue, alpha),
             // If there are three colors, this array has 4*3 elements,
             // locations: Where the color is located (range 0~1), 
             // the number of the array is not less than the number of colors in the components.
             // count: Number of gradient, equal to the number of locations
            let compoents:[CGFloat] = [ 0, 0.0, blue[i], 1.0,
                                        0, 0.0, blue[i] * 2, 1.0,
                                        1.0, 1.0, 1.0, 1.0]
            
            let locations:[CGFloat] = [0, 0.4, 1]
            let gradient = CGGradientCreateWithColorComponents(colorSpace, compoents, locations, locations.count)
            
            let alpha = CGFloat((cityDailyForecast![i].wind?.deg)!) / CGFloat(360) * CGFloat(2 * M_PI)
            let x = LABEL_WIDTH / 2 * cos(alpha)
            let y = LABEL_WIDTH / 3 * sin(alpha)

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
                                        CGPointMake(LABEL_WIDTH / 2 + LABEL_WIDTH * CGFloat(i), LABEL_WIDTH / 3), 0,
                                        CGPointMake(LABEL_WIDTH / 2 + LABEL_WIDTH * CGFloat(i) + x, LABEL_WIDTH / 3 + y),
                                        LABEL_WIDTH * blue[i] * 0.25,
                                        CGGradientDrawingOptions.DrawsBeforeStartLocation)
        }
    }
    
}