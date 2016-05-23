//
//  TimeModel.swift
//  Weather
//
//  Created by Shen Lijia on 16/5/22.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class TimeModel: NSObject {
    
    var timeList = [TimeDate]()
    
    override init(){
        super.init()
        
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath())")
    }
    
    // Save data
    func saveData() {
        let data = NSMutableData()
        
        // Declare an archive processing object
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        
        // Lists to correspond to the Checklist keyword coding
        archiver.encodeObject(timeList, forKey: "timeList")
        
        // End of code
        archiver.finishEncoding()
        
        // Data write
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    // Read data
    func loadData() {
        
        // Get local data file
        let path = self.dataFilePath()
        
        // Declaration file manager
        let defaultManager = NSFileManager()
        
        // Judging whether a data file exists through a file address
        if defaultManager.fileExistsAtPath(path) {
            
            // Read file data
            let data = NSData(contentsOfFile: path)
            
            // decoder
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            
            // The keyword Checklist restore lists
            timeList = unarchiver.decodeObjectForKey("timeList") as! Array
            
            // End decoding
            unarchiver.finishDecoding()
        }
    }
    
    // Get the sandbox folder path
    func documentsDirectory() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(
            NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory:String = paths.first! as String
        return documentsDirectory
    }
    
    // Get data file address
    func dataFilePath () -> String{
        
        return self.documentsDirectory().stringByAppendingString("timeList.plist")
    }
}
