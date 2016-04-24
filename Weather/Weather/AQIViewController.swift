//
//  AQIViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/4/10.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class AQIViewController: UIViewController, GeneralAQIViewDelegate {

    let scroll = UIScrollView();
    var cityAQI = WeatherData.CityAQI()
    
    // set constants value
    let WIDTH: CGFloat = UIScreen.mainScreen().bounds.size.width
    let HIGHT: CGFloat = (UIScreen.mainScreen().bounds.size.height + 10) / 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScroll()
        self.view.addSubview(scroll)
    }
    
    func setScroll() {
        
        // set the size of Scrollview
        scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, HIGHT * 8)
        
        // content size
        scroll.contentSize = CGSizeMake(WIDTH, HIGHT)
        
        // whether to support paging
        // scroll.pagingEnabled = true
        // padding
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        
        // draw AQI data
        var subVlew: GeneralAQIView = AQIView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.size.height, width: WIDTH, height: HIGHT))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.center = CGPointMake(WIDTH / 2, 0)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        scroll.addSubview(subVlew)
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(5.5)
        subVlew.center = CGPointMake(WIDTH / 2, HIGHT / 2)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        // draw CO data
        subVlew = COView(frame: CGRect(x: 0, y: HIGHT, width: WIDTH, height: HIGHT))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.center = CGPointMake(WIDTH / 2, 0)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        scroll.addSubview(subVlew)
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(5.0)
        subVlew.center = CGPointMake(WIDTH / 2, HIGHT + HIGHT / 2)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        // draw NO2 data
        subVlew = NO2View(frame: CGRect(x: 0, y: HIGHT * 2, width: WIDTH, height: HIGHT))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.center = CGPointMake(WIDTH / 2, 0)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        scroll.addSubview(subVlew)
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(4.5)
        subVlew.center = CGPointMake(WIDTH / 2, HIGHT * 2 + HIGHT / 2)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        // draw o3 data
        subVlew = O3View(frame: CGRect(x: 0, y: HIGHT * 3, width: WIDTH, height: HIGHT))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.center = CGPointMake(WIDTH / 2, 0)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        scroll.addSubview(subVlew)
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(4.0)
        subVlew.center = CGPointMake(WIDTH / 2, HIGHT * 3 + HIGHT / 2)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        
        // draw pm10 data
        subVlew = PM10View(frame: CGRect(x: 0, y: HIGHT * 4, width: WIDTH, height: HIGHT))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.center = CGPointMake(WIDTH / 2, 0)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        scroll.addSubview(subVlew)
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(3.5)
        subVlew.center = CGPointMake(WIDTH / 2, HIGHT * 4 + HIGHT / 2)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()

        
        // draw pm25 data
        subVlew = PM25View(frame: CGRect(x: 0, y: HIGHT * 5, width: WIDTH, height: HIGHT))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.center = CGPointMake(WIDTH / 2, 0)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        scroll.addSubview(subVlew)
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(3.0)
        subVlew.center = CGPointMake(WIDTH / 2, HIGHT * 5 + HIGHT / 2)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()

        
        // MARK - draw so2 data
        subVlew = SO2View(frame: CGRect(x: 0, y: HIGHT * 6, width: WIDTH, height: HIGHT))
        subVlew.dataSource = self
        subVlew.backgroundColor = UIColor.clearColor()
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)
        subVlew.center = CGPointMake(WIDTH / 2, 0)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()
        
        scroll.addSubview(subVlew)
        
        // add Mobile animation
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.5)
        subVlew.center = CGPointMake(WIDTH / 2, HIGHT * 6 + HIGHT / 2)
        
        // Set the relative speed of the animation
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        UIView.commitAnimations()

    }
    
    // ViewDelegate
    // TemperatureView
    func dataForGeneralAQIView(sender: GeneralAQIView) -> WeatherData.CityAQI {
        return cityAQI
    }
}


