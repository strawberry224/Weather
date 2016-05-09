//
//  NoticeSetting.swift
//  Weather
//
//  Created by Shen Lijia on 16/5/7.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import Foundation

class NoticeSetting {
    
    // set morning notice
    var aqiFlag = false
    var maxTmpFlag = false
    var minTmpFlag = false
    var diffTmpFlag = false
    var pcpnFlag = false
    
    var aqiString = "😷今日空气质量较差\n"
    var maxTmpString = "☀️今日温度较高，做好防晒准备\n"
    var minTmpString = "❄️今日温度较低，注意保暖\n"
    var diffTmpString = "⚠️今日温差较大,注意温度变化\n"
    var pcpnString = "💧今日有降雨，请带好雨具\n"
    
    func mergeMorningStrings() -> String {
        var noticeString = ""
        
        if (maxTmpFlag) {
            noticeString += maxTmpString
        }
        if (minTmpFlag) {
            noticeString += minTmpString
        }
        if (diffTmpFlag) {
            noticeString += diffTmpString
        }
        if (pcpnFlag) {
            noticeString += pcpnString
        }
        
        return noticeString
    }
    
    
    // set evening notice
    var tomrrowTmpFlag = false
    var tomrrowPcpnFlag = false
    
    var tomrrowTmpString = "⚠️今明两天温差较大,注意增减衣物\n"
    var tomrrowPcpnString = "💧明日有降雨，请带好雨具\n"
    
    func mergeEveningStrings() -> String {
        var noticeString = ""
        
        if (tomrrowTmpFlag) {
            noticeString += tomrrowTmpString
        }
        if (tomrrowPcpnFlag) {
            noticeString += tomrrowPcpnString
        }
        return noticeString
    }
    
    // set hourly notice
    var hourTmpFlag = false
    var hourPopFlag = false
    
    var hourTmpString = "⚠️未来三小时气温变化较大,注意增减衣物\n"
    var hourPopString = "💧未来三小时可能有降雨，请带好雨具\n"
    
    func mergeCurrentStrings() -> String {
        var noticeString = ""
        
        if (hourTmpFlag) {
            noticeString += hourTmpString
        }
        if (hourPopFlag) {
            noticeString += hourPopString
        }
        if (aqiFlag) {
            noticeString += aqiString
        }
        
        return noticeString
    }
}