//
//  TodayViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/22.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, TodayViewDelegate {
    
    let scroll = UIScrollView();
    
    // According to nightFlag to change the background color
    var nightFlag: Bool?
    var now =  WeatherData.Now()
    
    override func viewDidLoad() {
        if (nightFlag == true) {
            self.view.backgroundColor = UIColor.blackColor()
        }
        
        setScroll()
        self.view.addSubview(scroll)
    }
    
    func setScroll() {
        
        // set the size of Scrollview
        scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        // content size
        scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)
        
        // whether to support paging
        // scroll.pagingEnabled = true
        // padding
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        
        // draw AQI data
        let subVlew = TodayView(frame: CGRect(x: 0, y: 0,
            width: self.view.frame.size.width, height: self.view.frame.size.height))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        
        // add Fade animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.alpha = 0.0
        UIView.commitAnimations()
        
        scroll.addSubview(subVlew)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.alpha = 1.0
        UIView.commitAnimations()
    }
    
    // ViewDelegate
    func dataForTodayView(sender: TodayView) -> (WeatherData.Now) {
        return (now)
    }
    
    func timeForTodayView(sender: TodayView) -> Bool {
        return nightFlag!
    }
}

    