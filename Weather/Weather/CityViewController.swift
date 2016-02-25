//
//  SelectCityTableView.swift
//  Weather
//
//  Created by Shen Lijia on 16/2/18.
//  Copyright © 2016年 ShenLijia. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    
    var items: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = NSBundle.mainBundle().pathForResource("citylist", ofType: "plist")!
        let provinceArray = NSArray(contentsOfFile: plistPath)!
        let a = provinceArray[0] as? NSDictionary
        items = (a?.allKeys)!
        
        // Create table view
        self.tableView = UITableView(frame: self.view.frame, style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        
        // Create a reusable cell
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        self.view.addSubview(self.tableView!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // To configure the tableview
        //configureTableView()
        
        // After loading the data
        //loadCellDescriptors()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDelegate & Datasource
    
    // The number of groups
    func numberOfRowsInSection(section: Int) -> Int{
        return items.count;
    }
    
    // Is specified in the UITableView how many section
    // section partition
    // a section will contain more than Cell
    // there is only one section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Is specified in each of the section which has a number of Cell.
    // Because we have only one section
    // how many cities have the number of optional Cell
    // This is depending on the situation.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    // Initialize every Cell.
    // A Cell looks like it is determined by this method.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = items[indexPath.row] as? String
        return cell
    }
    
    // Is the method of selecting an Cell after execution.
    // When the user selects a cell, we need to know which one it is
    // and the cell of the city's name sent to the main interface used to access the city's weather data.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
}
