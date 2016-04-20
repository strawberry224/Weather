//
//  Normalization.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/8.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

// f(x) = (x - min) / (max - min)
// when input values are integer
func normalization(array: [Int]) -> [CGFloat] {
    var result = [CGFloat]()
    let min = array.minElement()
    let max = array.maxElement()
    for i in 0...array.count - 1 {
        result.append(CGFloat(array[i] - min!) / CGFloat(max! - min!))
    }
    return result
}

// when input values are double
func normalization(array: [Double]) -> [CGFloat] {
    var result = [CGFloat]()
    let min = array.minElement()
    let max = array.maxElement()
    for i in 0...array.count - 1 {
        result.append(CGFloat(array[i] - min!) / CGFloat(max! - min!))
    }
    return result
}

// AQI value normalization
// Int -> (red, green)
func normalization(aqi: Int) -> UIColor {
    switch aqi / 50 {
    case 0:
        return UIColor.greenColor();
    case 1:
        return UIColor.yellowColor()
    case 2:
        return UIColor.orangeColor()
    case 3:
        return UIColor.redColor()
    case 4, 5:
        return UIColor.purpleColor()
    default:
        return UIColor.brownColor()
    }
}