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
            /*
             绘制线性渐变
             context:图形上下文
             gradient:渐变色
             startPoint:起始位置
             startRadius:起始半径（通常为0，否则在此半径范围内容无任何填充）
             endCenter:终点位置（通常和起始点相同，否则会有偏移）
             endRadius:终点半径（也就是渐变的扩散长度）
             options:绘制方式,DrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
             DrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
             */
            CGContextDrawRadialGradient(context, gradient,
                                        CGPointMake(LABEL_WIDTH / 2 + LABEL_WIDTH * CGFloat(i), LABEL_WIDTH / 3), 0,
                                        CGPointMake(LABEL_WIDTH / 2 + LABEL_WIDTH * CGFloat(i) + x, LABEL_WIDTH / 3 + y),
                                        LABEL_WIDTH * blue[i] * 0.25,
                                        CGGradientDrawingOptions.DrawsBeforeStartLocation)
        }
    }
    
}