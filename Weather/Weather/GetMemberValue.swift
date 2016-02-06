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
        
        cityAQI.aqi = Int(city["aqi"]!.integerValue)
        cityAQI.co = Int(city["co"]!.integerValue)
        cityAQI.no2 = Int(city["no2"]!.integerValue)
        cityAQI.o3 = Int(city["o3"]!.integerValue)
        cityAQI.pm10 = Int(city["pm10"]!.integerValue)
        cityAQI.pm25 = Int(city["pm25"]!.integerValue)
        cityAQI.qlty = String(city["qlty"]!)
        cityAQI.so2 = Int(city["so2"]!.integerValue)
        
        //testCityAQI(cityAQI)
        
        return cityAQI
    }
    
    func testCityAQI(cityAQI: WeatherData.CityAQI) {
        
        print(cityAQI.aqi)
        print(cityAQI.co)
        print(cityAQI.no2)
        print(cityAQI.o3)
        print(cityAQI.pm10)
        print(cityAQI.pm25)
        print(cityAQI.qlty)
        print(cityAQI.so2)
    }
    
    // MARK: - Basic Public API
    
    func getBasic(city: NSDictionary) -> WeatherData.Basic {
        
        let cityBasic = WeatherData.Basic()
        
        cityBasic.city = String(city["city"]!)
        cityBasic.cnty = String(city["cnty"]!)
        cityBasic.id = String(city["id"]!)
        cityBasic.lat = Double(city["lat"]!.doubleValue)
        cityBasic.lon = Double(city["lon"]!.doubleValue)
        
        if let BasicUpdate = city["update"] as? NSDictionary {
            let loc = String(BasicUpdate["loc"]!)
            let utc = String(BasicUpdate["utc"]!)
            let tempUpdate = WeatherData.Update(loc: loc, utc: utc)
            cityBasic.update = tempUpdate
        }
        
        //testBasic(cityBasic)
        
        return cityBasic
    }
    
    func testBasic(cityBasic: WeatherData.Basic) {
        
        print(cityBasic.city)
        print(cityBasic.cnty)
        print(cityBasic.id)
        print(cityBasic.lat)
        print(cityBasic.lon)
        print(cityBasic.update?.loc)
        print(cityBasic.update?.utc)
    }
    
    // MARK: - DailyForecast Public API
    
    func getDailyForecast(city: NSDictionary) -> WeatherData.DailyForecast {
        
        let cityDailyForecast = WeatherData.DailyForecast()
        
        if let astro = city["astro"] as? NSDictionary {
            let sr = String(astro["sr"]!)
            let ss = String(astro["ss"]!)
            let tempAstro = WeatherData.Astro(sr: sr, ss: ss)
            cityDailyForecast.astro = tempAstro
        }
        
        if let cond = city["cond"] as? NSDictionary {
            let codeD = Int(cond["code_d"]!.integerValue)
            let codeN = Int(cond["code_n"]!.integerValue)
            let txtD = String(cond["txt_d"]!)
            let txtN = String(cond["txt_n"]!)
            let tempCond = WeatherData.DailyCond(codeD: codeD, codeN: codeN, txtD: txtD, txtN: txtN)
            cityDailyForecast.cond = tempCond
        }
        
        cityDailyForecast.date = String(city["date"]!)
        cityDailyForecast.hum = Int(city["hum"]!.integerValue)
        cityDailyForecast.pcpn = Double(city["pcpn"]!.doubleValue)
        cityDailyForecast.pop = Int(city["pop"]!.integerValue)
        
        if let tmp = city["tmp"] as? NSDictionary {
            let max = Int(tmp["max"]!.integerValue)
            let min = Int(tmp["min"]!.integerValue)
            let tempTmp = WeatherData.Tmp(max: max, min: min)
            cityDailyForecast.tmp = tempTmp
        }
        
        cityDailyForecast.vis = Int(city["vis"]!.integerValue)
        
        if let wind = city["wind"] as? NSDictionary {
            let deg = Int(wind["deg"]!.integerValue)
            let dir = String(wind["dir"]!)
            let sc = String(wind["sc"]!)
            let spd = Int(wind["spd"]!.integerValue)
            let tempWind = WeatherData.Wind(deg: deg, dir: dir, sc: sc, spd: spd)
            cityDailyForecast.wind = tempWind
        }
        
        //testDailyForecast(cityDailyForecast)
        
        return cityDailyForecast
    }
    
    func testDailyForecast(cityDailyForecast: WeatherData.DailyForecast) {
        
        print(cityDailyForecast.astro?.sr)
        print(cityDailyForecast.astro?.ss)
        print(cityDailyForecast.cond?.codeD)
        print(cityDailyForecast.cond?.codeN)
        print(cityDailyForecast.cond?.txtD)
        print(cityDailyForecast.cond?.txtN)
        print(cityDailyForecast.date)
        print(cityDailyForecast.hum)
        print(cityDailyForecast.pcpn)
        print(cityDailyForecast.pop)
        print(cityDailyForecast.tmp?.max)
        print(cityDailyForecast.tmp?.min)
        print(cityDailyForecast.wind?.deg)
        print(cityDailyForecast.wind?.dir)
        print(cityDailyForecast.wind?.sc)
        print(cityDailyForecast.wind?.spd)
    }

    func getHourlyForecast(city: NSDictionary) -> WeatherData.HourlyForecast {
        
        let cityHourlyForecast = WeatherData.HourlyForecast()
        
        cityHourlyForecast.date = String(city["date"]!)
        cityHourlyForecast.hum = Int(city["hum"]!.integerValue)
        cityHourlyForecast.pop = Int(city["pop"]!.integerValue)
        cityHourlyForecast.pres = Int(city["pres"]!.integerValue)
        cityHourlyForecast.tmp = Int(city["tmp"]!.integerValue)
        if let wind = city["wind"] as? NSDictionary {
            let deg = Int(wind["deg"]!.integerValue)
            let dir = String(wind["dir"]!)
            let sc = String(wind["sc"]!)
            let spd = Int(wind["spd"]!.integerValue)
            let tempWind = WeatherData.Wind(deg: deg, dir: dir, sc: sc, spd: spd)
            cityHourlyForecast.wind = tempWind
        }
        
        //testHourlyForecast(cityHourlyForecast)
        
        return cityHourlyForecast
    }
    
    func testHourlyForecast(cityHourlyForecast: WeatherData.HourlyForecast) {
        
        print(cityHourlyForecast.date)
        print(cityHourlyForecast.hum)
        print(cityHourlyForecast.pop)
        print(cityHourlyForecast.pres)
        print(cityHourlyForecast.tmp)
        print(cityHourlyForecast.wind?.deg)
        print(cityHourlyForecast.wind?.dir)
        print(cityHourlyForecast.wind?.sc)
        print(cityHourlyForecast.wind?.spd)
    }
    
    func getNow(city: NSDictionary) -> WeatherData.Now {
        let cityNow = WeatherData.Now()
        
        if let cond = city["cond"] as? NSDictionary {
            let code = Int(cond["code"]!.integerValue)
            let txt = String(cond["txt"]!)
            let tempCond = WeatherData.NowCond(code: code, txt: txt)
            cityNow.cond = tempCond
        }
        
        cityNow.fl = Int(city["fl"]!.integerValue)
        cityNow.hum = Int(city["hum"]!.integerValue)
        cityNow.pcpn = Int(city["pcpn"]!.integerValue)
        cityNow.pres = Int(city["pres"]!.integerValue)
        cityNow.tmp = Int(city["tmp"]!.integerValue)
        cityNow.vis = Int(city["vis"]!.integerValue)
        
        if let wind = city["wind"] as? NSDictionary {
            let deg = Int(wind["deg"]!.integerValue)
            let dir = String(wind["dir"]!)
            let sc = String(wind["sc"]!)
            let spd = Int(wind["spd"]!.integerValue)
            let tempWind = WeatherData.Wind(deg: deg, dir: dir, sc: sc, spd: spd)
            cityNow.wind = tempWind
        }
        
        //testNow(cityNow)

        return cityNow
    }

    func testNow(cityNow: WeatherData.Now) {
        
        print(cityNow.cond?.code)
        print(cityNow.cond?.txt)
        print(cityNow.fl)
        print(cityNow.hum)
        print(cityNow.pcpn)
        print(cityNow.pres)
        print(cityNow.tmp)
        print(cityNow.vis)
        print(cityNow.wind?.deg)
        print(cityNow.wind?.dir)
        print(cityNow.wind?.sc)
        print(cityNow.wind?.spd)
    }
    
    func lifeDate(key: String, city: NSDictionary) -> WeatherData.Life {
        if let life = city[key] as? NSDictionary {
            let brf = String(life["brf"]!)
            let txt = String(life["txt"]!)
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
        
        //testSuggestion(citySuggestion)
        
        return citySuggestion
    }
    
    func testSuggestion(citySuggestion: WeatherData.Suggestion) {
        
        print(citySuggestion.comf?.brf)
        print(citySuggestion.comf?.txt)
        print(citySuggestion.cw?.brf)
        print(citySuggestion.cw?.txt)
        print(citySuggestion.drsg?.brf)
        print(citySuggestion.drsg?.txt)
        print(citySuggestion.flu?.brf)
        print(citySuggestion.flu?.txt)
        print(citySuggestion.sport?.brf)
        print(citySuggestion.sport?.txt)
        print(citySuggestion.trav?.brf)
        print(citySuggestion.trav?.txt)
        print(citySuggestion.uv?.brf)
        print(citySuggestion.uv?.txt)
    }

}