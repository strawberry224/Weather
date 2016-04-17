//
//  AQIViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/10.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class AQIViewController: UIViewController, AQIViewDelegate {
    
    let scroll = UIScrollView();
    var cityAQI = WeatherData.CityAQI()
    
    // set constants value
    let WIDTH: CGFloat = 200
    let HIGHT: CGFloat = UIScreen.mainScreen().bounds.size.height
    
    override func viewDidLoad() {
        setScroll()
        self.view.addSubview(scroll)
    }
    
    func setScroll() {
        
        // set the size of Scrollview
        scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, HIGHT)
        
        // content size
        scroll.contentSize = CGSizeMake(WIDTH * 8, HIGHT)
        
        // whether to support paging
        // scroll.pagingEnabled = true
        // padding
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        
        let subVlew = AQIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: self.view.frame.size.height))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        scroll.addSubview(subVlew)
    }
    
    // ViewDelegate
    // TemperatureView
    func dataForAQIView(sender: AQIView) -> WeatherData.CityAQI {
        return cityAQI
    }
}


