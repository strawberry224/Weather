//
//  Normalization.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/8.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit


func normalization(array: [Int]) -> [CGFloat] {
    var result = [CGFloat]()
    let min = array.minElement()
    let max = array.maxElement()
    for i in 0...array.count - 1 {
        result.append(CGFloat(array[i] - min!) / CGFloat(max! - min!))
    }
    return result
}

func normalization(array: [Double]) -> [CGFloat] {
    var result = [CGFloat]()
    let min = array.minElement()
    let max = array.maxElement()
    for i in 0...array.count - 1 {
        result.append(CGFloat(array[i] - min!) / CGFloat(max! - min!))
    }
    return result
}