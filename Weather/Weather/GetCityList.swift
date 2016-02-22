//
//  GetCityList.swift
//  Weather
//
//  Created by Shen Lijia on 16/2/19.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import Foundation

class GetCityList {
    
    // MARK: - CityList Public API
    
    func getCityList(city: NSDictionary) -> CityListData {
        
        let cityList = CityListData()
        
        cityList.city = String(city["city"]!)
        cityList.prov = String(city["prov"]!)
        
        return cityList
    }

}