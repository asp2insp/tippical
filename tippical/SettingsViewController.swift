//
//  SettingsViewController.swift
//  tippical
//
//  Created by Josiah Gaskin on 4/9/15.
//  Copyright (c) 2015 Josiah Gaskin. All rights reserved.
//

import UIKit

let kSegmentSettingsKey = "SEGMENT_SETTINGS_ARRAY"

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var valueSlider: UISlider!
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var tipChoicesTable: UITableView!
    
    @IBAction func doneTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var TIP: [Double] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.TIP.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tipChoicesTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = "\(self.TIP[indexPath.row])"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        valueSlider.value = Float(TIP[indexPath.row])
    }
    
    func refreshChoices() {
        defaultTipControl.removeAllSegments()
        for t in TIP {
            let fmt = Int(t*100)
            defaultTipControl.insertSegmentWithTitle("\(fmt)%", atIndex: TIP.count, animated:false)
        }
        tipChoicesTable.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let savedTips = defaults.arrayForKey(kSegmentSettingsKey) {
            TIP = savedTips as [Double]
        } else {
            TIP = [0.15, 0.18, 0.2, 0.25]
            defaults.setObject(TIP, forKey: kSegmentSettingsKey)
        }
        
        refreshChoices()
        self.tipChoicesTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func sliderChanged(sender: AnyObject) {
        if let selectedIndex = tipChoicesTable.indexPathForSelectedRow()?.row {
            TIP[selectedIndex] = Double(valueSlider.value);
        }
        refreshChoices()
    }
}