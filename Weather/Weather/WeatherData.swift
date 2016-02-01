//
//  WeatherData.swift
//  Weather
//
//  Created by Shen Lijia on 16/1/31.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import Foundation

class WeatherData: NSObject {
    
    var cityAQI: CityAQI?
    var cityBasic: Basic?
    var cityDailyForecast: [DailyForecast?] = []
    
    class CityAQI: NSObject {
        var aqi: Int?
        var co: Int?
        var no2: Int?
        var o3: Int?
        var pm10: Int?
        var pm25: Int?
        var qlty: String?
        var so2: Int?
        
    }
    
    class Basic: NSObject {
        var city: String?
        var cnty: String?
        var id: String?
        var lat: Double?
        var lon: Double?
        var update: Update?
    }
    
    class Update {
        var loc: String?
        var utc: String?
        
        init(loc: String?, utc: String?) {
            self.loc = loc
            self.utc = utc
        }
    }
    
    class DailyForecast: NSObject {
        var astro: Astro?
        var cond: Cond?
        var date: String?
        var hum: Int?
        var pcpn: Double?
        var pop: Int?
        var pres: Int?
        var tmp: Tmp?
        var vis: Int?
        var wind: Wind?
    }
    
    class Astro {
        var sr: String?
        var ss: String?
        
        init(sr: String?, ss: String?) {
            self.sr = sr
            self.ss = ss
        }
    }
    
    class Cond {
        var codeD: Int?
        var codeN: Int?
        var txtD: String?
        var txtN: String?
        
        init(codeD: Int?, codeN: Int?, txtD: String?, txtN: String?) {
            self.codeD = codeD
            self.codeN = codeN
            self.txtD = txtD
            self.txtN = txtN
        }
    }
    
    class Tmp {
        var max: Int?
        var min: Int?
        
        init(max: Int?, min: Int?) {
            self.max = max
            self.min = min
        }
    }
    
    class Wind {
        var deg: Int?
        var dir: String?
        var sc: String?
        var spd: Int?
        
        init(deg: Int?, dir: String?, sc: String?, spd: Int?) {
            self.deg = deg
            self.dir = dir
            self.sc = sc
            self.spd = spd
        }
    }
}