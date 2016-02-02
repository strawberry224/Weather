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
    
    // Air quality
    // only the domestic part of the city
    // the international city without this field
    class CityAQI: NSObject {
        var aqi: Int? // Air quality index
        var co: Int? // Carbon monoxide 1 hour average (ug/m fand)
        var no2: Int? // 1 hour average nitrogen dioxide (ug/m fand)
        var o3: Int? // 1 hour average ozone (ug/m fand)
        var pm10: Int? // PM10 1 hour average (ug/m fand)
        var pm25: Int? // PM2.5 1 hour average (ug/m fand)
        var qlty: String? // Air quality category
        var so2: Int? // Sulfur dioxide 1 hour average (ug/m fand)
        
    }
    
    class Basic: NSObject { // Basic information
        var city: String? // City name
        var cnty: String? // Country
        var id: String? // City ID
        var lat: Double? // City latitude
        var lon: Double? // City longitude
        var update: Update? // Update time
    }
    
    class Update {
        var loc: String? // Local time
        var utc: String? // UTC time
        
        init(loc: String?, utc: String?) {
            self.loc = loc
            self.utc = utc
        }
    }
    
    class DailyForecast: NSObject { // 7 days weather forecast
        var astro: Astro? // Astronomical value
        var cond: DailyCond? // weather condition
        var date: String? // Forecast date
        var hum: Int? // Relative humidity (%)
        var pcpn: Double? // Precipitation (mm)
        var pop: Int? // Precipitation probability
        var pres: Int? // pressure
        var tmp: Tmp? // temperature
        var vis: Int? // Visibility (km)
        var wind: Wind?
    }
    
    class Astro {
        var sr: String? // Sunrise time
        var ss: String? // Sunset time
        
        init(sr: String?, ss: String?) {
            self.sr = sr
            self.ss = ss
        }
    }
    
    class DailyCond {
        var codeD: Int? // Day weather condition code
        var codeN: Int? // Night weather condition code
        var txtD: String? // Description of weather conditions during the day
        var txtN: String? // Description of the weather condition at night
        
        init(codeD: Int?, codeN: Int?, txtD: String?, txtN: String?) {
            self.codeD = codeD
            self.codeN = codeN
            self.txtD = txtD
            self.txtN = txtN
        }
    }
    
    class NowCond {
        var code: Int? // Weather condition code
        var txt: String? // Description of weather conditions
        
        init(code: Int?, txt: String?) {
            self.code = code
            self.txt = txt
        }
    }
    
    class Tmp {
        var max: Int? // Maximum temperature
        var min: Int? // Minimum temperature
        
        init(max: Int?, min: Int?) {
            self.max = max
            self.min = min
        }
    }
    
    class Wind {
        var deg: Int? // Wind direction (360 degrees)
        var dir: String? // Wind direction
        var sc: String? // Wind power
        var spd: Int? // Wind velocity (kmph)
        
        init(deg: Int?, dir: String?, sc: String?, spd: Int?) {
            self.deg = deg
            self.dir = dir
            self.sc = sc
            self.spd = spd
        }
    }
    
    class HourlyForecast: NSObject { // Weather forecast for every three hours
        var date: String? // time
        var hum: Int? // Relative humidity (%)
        var pop: Int? // Precipitation probability
        var pres: Int? // pressure
        var tmp: Int? // temperature
        var wind: Wind? // Wind direction
    }
    
    class Now: NSObject { //Live weather
        var cond: NowCond? // weather condition
        var fl: Int? // Body temperature
        var hum: Int? // Relative humidity (%)
        var pcpn: Int? // Precipitation (mm)
        var pres: Int? // pressure
        var tmp: Int? // temperature
        var vis: Int? // Visibility (km)
        var wind: Wind? // Wind direction
    }
    
    class Life {
        var brf: String? // brief introduction
        var txt: String? // Detailed description
        
        init(brf: String?, txt: String?) {
            self.brf = brf
            self.txt = txt
        }
    }
    
    // Life index
    // only domestic cities
    // international cities without this field
    class Suggestion: NSObject {
        var comf: Life? // Comfort index
        var cw: Life? // Car wash index
        var drsg: Life? // Dressing index
        var flu: Life? // Cold index
        var sport: Life? // Movement index
        var trav: Life? // Travel Index
        var uv: Life? // UV index
    }
}