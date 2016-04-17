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
func normalization(colorNum: Int, alpha: CGFloat) -> UIColor {
    //let tmpColor: CGFloat = 255 - (CGFloat(colorNum) - 50) * 10;
    
    var red: CGFloat = 0, green: CGFloat = 0;
    if (colorNum * 2 > 255) {
        red = 255;
        green = 255 * 2 - CGFloat(colorNum);
    } else {
        red = CGFloat(colorNum);
        green = 255;
    }
    let color = UIColor(red: red / 255.0, green: green / 255.0, blue: 0, alpha: alpha)
    return color
}