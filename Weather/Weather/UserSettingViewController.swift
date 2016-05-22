//
//  UserSettingViewController.swift
//  Weather
//
//  Created by Shen Lijia on 16/5/17.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class UserSettingViewController: UIViewController {
    
    @IBOutlet weak var MorningSwitch: UISwitch!
    @IBOutlet weak var EveningSwitch: UISwitch!
    @IBOutlet weak var RealtimeSwitch: UISwitch!
    
    @IBOutlet weak var MorningDataPicker: UIDatePicker!
    @IBOutlet weak var EveningDatePicker: UIDatePicker!
    
    var morningTime = String()
    var eveningTime = String()
    var realTime = String()
    
    var timeModel = TimeModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        // k = Hour in 1~24, mm = Minute
        dateFormatter.dateFormat = "k:mm"
        
        let morningDate = dateFormatter.dateFromString(morningTime)

        MorningDataPicker.setDate(morningDate!, animated: true )
        MorningDataPicker.addTarget(self, action: #selector(UserSettingViewController.morningDataPickerDidChange),
                                forControlEvents:UIControlEvents.ValueChanged)

        MorningSwitch.addTarget(self, action: #selector(UserSettingViewController.morningSwitchDidChange),
                           forControlEvents:UIControlEvents.ValueChanged)
        
        let eveningDate = dateFormatter.dateFromString(eveningTime)
        
        EveningDatePicker.setDate(eveningDate!, animated: true )
        EveningDatePicker.addTarget(self, action: #selector(UserSettingViewController.eveningDatePickerDidChange),
                                forControlEvents:UIControlEvents.ValueChanged)
        EveningSwitch.addTarget(self, action: #selector(UserSettingViewController.eveningSwitchDidChange),
                                forControlEvents:UIControlEvents.ValueChanged)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func morningDataPickerDidChange(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        // k = Hour in 1~24, mm = Minute
        dateFormatter.dateFormat = "k:mm"
        morningTime = dateFormatter.stringFromDate(MorningDataPicker.date)
        
        print(morningTime)
    }
    
    func morningSwitchDidChange(){
        if (MorningSwitch.on) {
            MorningDataPicker.hidden = false
        } else {
            MorningDataPicker.hidden = true
        }
    }
    
    func eveningDatePickerDidChange(){
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        // k = Hour in 1~24, mm = Minute
        dateFormatter.dateFormat = "k:mm"
        eveningTime = dateFormatter.stringFromDate(EveningDatePicker.date)
        
        print(eveningTime)
    }
    
    func eveningSwitchDidChange(){
        if (EveningSwitch.on) {
            EveningDatePicker.hidden = false
        } else {
            EveningDatePicker.hidden = true
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
