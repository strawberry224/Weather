//
//  SuggestionViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/5/9.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {
    
    let scroll = UIScrollView();
    
    var citySuggestion = WeatherData.Suggestion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScroll()
        
        self.view.addSubview(scroll)
    }

    
    func setScroll() {
        
        // set the size of Scrollview
        scroll.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        // content size
        scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2.5)
        
        // whether to support paging
        // scroll.pagingEnabled = true
        // padding
        scroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        
        setLabels("舒适度指数", brf: (citySuggestion.comf?.brf)!, text: (citySuggestion.comf?.txt)!, offset: 0.0)
        setLabels("洗车指数", brf: (citySuggestion.cw?.brf)!, text: (citySuggestion.cw?.txt)!, offset: 150.0)
        setLabels("穿衣指数", brf: (citySuggestion.drsg?.brf)!, text: (citySuggestion.drsg?.txt)!, offset: 300.0)
        setLabels("感冒指数", brf: (citySuggestion.flu?.brf)!, text: (citySuggestion.flu?.txt)!, offset: 450.0)
        setLabels("运动指数", brf: (citySuggestion.sport?.brf)!, text: (citySuggestion.sport?.txt)!, offset: 600.0)
        setLabels("旅游指数", brf: (citySuggestion.trav?.brf)!, text: (citySuggestion.trav?.txt)!, offset: 750.0)
        setLabels("紫外线指数", brf: (citySuggestion.uv?.brf)!, text: (citySuggestion.uv?.txt)!, offset: 900.0)
    }
    
    func setLabels(comf: String, brf: String, text: String, offset: CGFloat) {
        let title = UILabel(frame: CGRectMake(8, 10 + offset, 100, 20))
        title.text = comf
        title.backgroundColor = UIColor(red: 0.5, green: 1.0, blue: 1.0, alpha: 1.0)
        title.font = UIFont(name:"Helvetica", size:19)
        scroll.addSubview(title)
        
        let brfLabel = UILabel(frame: CGRectMake(8, 40 + offset, 100, 20))
        brfLabel.text = brf
        brfLabel.backgroundColor = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0)
        brfLabel.font = UIFont(name:"Helvetica", size:17)
        scroll.addSubview(brfLabel)
        
        let textLabel = UILabel(frame: CGRectMake(8, 70 + offset, self.view.frame.size.width - 50, 60))
        textLabel.text = text
        textLabel.font = UIFont(name:"Helvetica", size:15)
        textLabel.numberOfLines = 0;
        scroll.addSubview(textLabel)

    }

}
