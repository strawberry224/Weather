//
//  TimeDate.swift
//  Weather
//
//  Created by Shen Lijia on 16/5/22.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class TimeDate: NSObject {
    
    var morningSwitch: Bool
    var eveningSwitch: Bool
    var realtimeSwitch: Bool
    
    var morningData: String
    var eveningDate: String
    
    // Construction method
    init(morningSwitch: Bool, eveningSwitch: Bool, realtimeSwitch: Bool, morningData: String, eveningDate: String){
        
        self.morningSwitch = morningSwitch
        self.eveningSwitch = eveningSwitch
        self.realtimeSwitch = realtimeSwitch
        
        self.morningData = morningData
        self.eveningDate = eveningDate
        
        super.init()
    }
    
    // Come back from nsobject
    init(coder aDecoder:NSCoder!){
        
        self.morningSwitch = aDecoder.decodeObjectForKey("morningSwitch") as! Bool
        self.eveningSwitch = aDecoder.decodeObjectForKey("eveningSwitch") as! Bool
        self.realtimeSwitch = aDecoder.decodeObjectForKey("realtimeSwitch") as! Bool
        
        self.morningData = aDecoder.decodeObjectForKey("morningData") as! String
        self.eveningDate = aDecoder.decodeObjectForKey("eveningDate") as! String
    }
    
    // Coded into object
    func encodeWithCoder(aCoder:NSCoder!){
        
        aCoder.encodeObject(morningSwitch, forKey:"morningSwitch")
        aCoder.encodeObject(eveningSwitch, forKey:"eveningSwitch")
        aCoder.encodeObject(realtimeSwitch, forKey:"realtimeSwitch")
        
        aCoder.encodeObject(morningData, forKey:"morningData")
        aCoder.encodeObject(eveningDate, forKey:"eveningDate")
    }
}
