//
//  GetMemberValue.swift
//  Weather
//
//  Created by Shen Lijia on 16/2/1.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import Foundation

class GetMemberValue {
    
    // MARK: - CityAQI Public API
    
    func getCityAQI(city: NSDictionary) -> WeatherData.CityAQI {
        
        let cityAQI = WeatherData.CityAQI()
        
        if ((city["aqi"]) != nil) {
            cityAQI.aqi = Int(city["aqi"]!.integerValue)
        } else {
            cityAQI.aqi = 0
        }
        
        if ((city["co"]) != nil) {
            cityAQI.co = Int(city["co"]!.integerValue)
        } else {
            cityAQI.co = 0
        }
        
        if ((city["no2"]) != nil) {
            cityAQI.no2 = Int(city["no2"]!.integerValue)
        } else {
            cityAQI.no2 = 0
        }
        
        if ((city["o3"]) != nil) {
            cityAQI.o3 = Int(city["o3"]!.integerValue)
        } else {
            cityAQI.o3 = 0
        }
        
        if ((city["pm10"]) != nil) {
            cityAQI.pm10 = Int(city["pm10"]!.integerValue)
        } else {
            cityAQI.pm10 = 0
        }
        
        if ((city["pm25"]) != nil) {
            cityAQI.pm25 = Int(city["pm25"]!.integerValue)
        } else {
            cityAQI.pm25 = 0
        }
        
        if ((city["qlty"]) != nil) {
            cityAQI.qlty = String(city["qlty"]!)
        } else {
            cityAQI.qlty = ""
        }
        
        if ((city["so2"]) != nil) {
            cityAQI.so2 = Int(city["so2"]!.integerValue)
        } else {
            cityAQI.so2 = 0
        }
        
        return cityAQI
    }
    
    // MARK: - Basic Public API
    
    func getBasic(city: NSDictionary) -> WeatherData.Basic {
        
        let cityBasic = WeatherData.Basic()
        
        if ((city["city"]) != nil) {
            cityBasic.city = String(city["city"]!)
        } else {
            cityBasic.city  = ""
        }
        
        if ((city["city"]) != nil) {
            cityBasic.city = String(city["city"]!)
        } else {
            cityBasic.city = ""
        }
        
        if ((city["id"]) != nil) {
            cityBasic.id = String(city["id"]!)
        } else {
            cityBasic.id = ""
        }
        
        if ((city["lat"]) != nil) {
            cityBasic.lat = Double(city["lat"]!.doubleValue)
        } else {
            cityBasic.lat = 0
        }
        
        if ((city["lon"]) != nil) {
            cityBasic.lon = Double(city["lon"]!.doubleValue)
        } else {
            cityBasic.lon = 0
        }
        
        if let BasicUpdate = city["update"] as? NSDictionary {
            
            // Variable initialization
            var loc = ""
            if ((BasicUpdate["loc"]) != nil) {
                loc = String(BasicUpdate["loc"]!)
            }
            
            // Variable initialization
            var utc = ""
            if ((BasicUpdate["utc"]) != nil) {
                utc = String(BasicUpdate["utc"]!)
            }
            
            let tempUpdate = WeatherData.Update(loc: loc, utc: utc)
            cityBasic.update = tempUpdate
        }
        
        return cityBasic
    }
    
    // MARK: - DailyForecast Public API
    
    func getDailyForecast(city: NSDictionary) -> WeatherData.DailyForecast {
        
        let cityDailyForecast = WeatherData.DailyForecast()
        
        if let astro = city["astro"] as? NSDictionary {
            
            // Variable initialization
            var sr = ""
            if ((astro["sr"]) != nil) {
                sr = String(astro["sr"]!)
            }
            
            // Variable initialization
            var ss = ""
            if ((astro["ss"]) != nil) {
                ss = String(astro["ss"]!)
            }
            
            let tempAstro = WeatherData.Astro(sr: sr, ss: ss)
            cityDailyForecast.astro = tempAstro
        }
        
        if let cond = city["cond"] as? NSDictionary {
            
            // Variable initialization
            var codeD = 0
            if ((cond["code_d"]) != nil) {
                codeD = Int(cond["code_d"]!.integerValue)
            }
            
            // Variable initialization
            var codeN = 0
            if ((cond["code_n"]) != nil) {
                codeN = Int(cond["code_n"]!.integerValue)
            }
            
            // Variable initialization
            var txtD = ""
            if ((cond["txt_d"]) != nil) {
                txtD = String(cond["txt_d"]!)
            }
            
            // Variable initialization
            var txtN = ""
            if ((cond["txt_n"]) != nil) {
                txtN = String(cond["txt_n"]!)
            }
            
            let tempCond = WeatherData.DailyCond(codeD: codeD, codeN: codeN, txtD: txtD, txtN: txtN)
            cityDailyForecast.cond = tempCond
        }
        
        if ((city["date"]) != nil) {
            cityDailyForecast.date = String(city["date"]!)
        } else {
            cityDailyForecast.date = ""
        }
        
        if ((city["hum"]) != nil) {
            cityDailyForecast.hum = Int(city["hum"]!.integerValue)
        } else {
            cityDailyForecast.hum = 0
        }
        
        if ((city["pcpn"]) != nil) {
            cityDailyForecast.pcpn = Double(city["pcpn"]!.doubleValue)
        } else {
            cityDailyForecast.pcpn = 0
        }
        
        if ((city["pop"]) != nil) {
            cityDailyForecast.pop = Int(city["pop"]!.integerValue)
        } else {
            cityDailyForecast.pop = 0
        }
        
        if let tmp = city["tmp"] as? NSDictionary {
            
            // Variable initialization
            var max = 0
            if ((tmp["max"]) != nil) {
                max = Int(tmp["max"]!.integerValue)
            }
            
            // Variable initialization
            var min = 0
            if ((tmp["min"]) != nil) {
                min = Int(tmp["min"]!.integerValue)
            }
            
            let tempTmp = WeatherData.Tmp(max: max, min: min)
            cityDailyForecast.tmp = tempTmp
        }
        
        cityDailyForecast.vis = Int(city["vis"]!.integerValue)
        
        if let wind = city["wind"] as? NSDictionary {
            
            // Variable initialization
            var deg = 0
            if ((wind["deg"]) != nil) {
                deg = Int(wind["deg"]!.integerValue)
            }
            
            // Variable initialization
            var dir = ""
            if ((wind["dir"]) != nil) {
                dir = String(wind["dir"]!)
            }
            
            // Variable initialization
            var sc = ""
            if ((wind["sc"]) != nil) {
                sc = String(wind["sc"]!)
            }
            
            // Variable initialization
            var spd = 0
            if ((wind["spd"]) != nil) {
                spd = Int(wind["spd"]!.integerValue)
            }
            
            let tempWind = WeatherData.Wind(deg: deg, dir: dir, sc: sc, spd: spd)
            cityDailyForecast.wind = tempWind
        }
        
        return cityDailyForecast
    }
    
    func getHourlyForecast(city: NSDictionary) -> WeatherData.HourlyForecast {
        
        let cityHourlyForecast = WeatherData.HourlyForecast()
        
        if ((city["date"]) != nil) {
            cityHourlyForecast.date = String(city["date"]!)
        } else {
            cityHourlyForecast.date = ""
        }
        
        if ((city["hum"]) != nil) {
            cityHourlyForecast.hum = Int(city["hum"]!.integerValue)
        } else {
            cityHourlyForecast.hum = 0
        }
        
        if ((city["pop"]) != nil) {
            cityHourlyForecast.pop = Int(city["pop"]!.integerValue)
        } else {
            cityHourlyForecast.pop = 0
        }
        
        if ((city["pres"]) != nil) {
            cityHourlyForecast.pres = Int(city["pres"]!.integerValue)
        } else {
            cityHourlyForecast.pres = 0
        }
        
        if ((city["tmp"]) != nil) {
            cityHourlyForecast.tmp = Int(city["tmp"]!.integerValue)
        } else {
            cityHourlyForecast.tmp = 0
        }
        
        if let wind = city["wind"] as? NSDictionary {
            
            // Variable initialization
            var deg = 0
            if ((wind["deg"]) != nil) {
                deg = Int(wind["deg"]!.integerValue)
            }
            
            // Variable initialization
            var dir = ""
            if ((wind["dir"]) != nil) {
                dir = String(wind["dir"]!)
            }
            
            // Variable initialization
            var sc = ""
            if ((wind["sc"]) != nil) {
                sc = String(wind["sc"]!)
            }
            
            // Variable initialization
            var spd = 0
            if ((wind["spd"]) != nil) {
                spd = Int(wind["spd"]!.integerValue)
            }
            
            let tempWind = WeatherData.Wind(deg: deg, dir: dir, sc: sc, spd: spd)
            cityHourlyForecast.wind = tempWind
        }
        
        return cityHourlyForecast
    }
    
    func getNow(city: NSDictionary) -> WeatherData.Now {
        
        let cityNow = WeatherData.Now()
        
        if let cond = city["cond"] as? NSDictionary {
            
            // Variable initialization
            var code = 0
            if ((cond["code"]) != nil) {
                code = Int(cond["code"]!.integerValue)
            }
            
            // Variable initialization
            var txt = ""
            if ((cond["txt"]) != nil) {
                txt = String(cond["txt"]!)
            }
            
            let tempCond = WeatherData.NowCond(code: code, txt: txt)
            cityNow.cond = tempCond
        }
        
        if ((city["fl"]) != nil) {
            cityNow.fl = Int(city["fl"]!.integerValue)
        } else {
            cityNow.fl = 0
        }
        
        if ((city["hum"]) != nil) {
            cityNow.hum = Int(city["hum"]!.integerValue)
        } else {
            cityNow.hum = 0
        }
        
        if ((city["pcpn"]) != nil) {
            cityNow.pcpn = Int(city["pcpn"]!.integerValue)
        } else {
            cityNow.pcpn = 0
        }
        
        if ((city["pres"]) != nil) {
            cityNow.pres = Int(city["pres"]!.integerValue)
        } else {
            cityNow.pres = 0
        }
        
        if ((city["tmp"]) != nil) {
            cityNow.tmp = Int(city["tmp"]!.integerValue)
        } else {
            cityNow.tmp = 0
        }
        
        if ((city["vis"]) != nil) {
            cityNow.vis = Int(city["vis"]!.integerValue)
        } else {
            cityNow.vis = 0
        }
        
        if let wind = city["wind"] as? NSDictionary {
            
            // Variable initialization
            var deg = 0
            if ((wind["deg"]) != nil) {
                deg = Int(wind["deg"]!.integerValue)
            }
            
            // Variable initialization
            var dir = ""
            if ((wind["dir"]) != nil) {
                dir = String(wind["dir"]!)
            }
            
            // Variable initialization
            var sc = ""
            if ((wind["sc"]) != nil) {
                sc = String(wind["sc"]!)
            }
            
            // Variable initialization
            var spd = 0
            if ((wind["spd"]) != nil) {
                spd = Int(wind["spd"]!.integerValue)
            }
            
            let tempWind = WeatherData.Wind(deg: deg, dir: dir, sc: sc, spd: spd)
            cityNow.wind = tempWind
        }
        
        return cityNow
    }
    
    func lifeDate(key: String, city: NSDictionary) -> WeatherData.Life {
        if let life = city[key] as? NSDictionary {
            
            // Variable initialization
            var brf = ""
            if ((life["brf"]) != nil) {
                brf = String(life["brf"]!)
            }
            
            // Variable initialization
            var txt = ""
            if ((life["txt"]) != nil) {
                txt = String(life["txt"]!)
            }
            
            return WeatherData.Life(brf: brf, txt: txt)
        }
        return WeatherData.Life(brf: "", txt: "")
    }
    
    func getSuggestion(city: NSDictionary) -> WeatherData.Suggestion {
        
        let citySuggestion = WeatherData.Suggestion()
        
        citySuggestion.comf = lifeDate("comf", city: city)
        citySuggestion.cw = lifeDate("cw", city: city)
        citySuggestion.drsg = lifeDate("drsg", city: city)
        citySuggestion.flu = lifeDate("flu", city: city)
        citySuggestion.sport = lifeDate("sport", city: city)
        citySuggestion.trav = lifeDate("trav", city: city)
        citySuggestion.uv = lifeDate("uv", city: city)
        
        return citySuggestion
    }
}