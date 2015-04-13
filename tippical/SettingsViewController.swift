//
//  SettingsViewController.swift
//  tippical
//
//  Created by Josiah Gaskin on 4/9/15.
//  Copyright (c) 2015 Josiah Gaskin. All rights reserved.
//

import UIKit

let kSegmentSettingsKey = "SEGMENT_SETTINGS_ARRAY"
let kDefaultTipAmount = "DEFAULT_TIP_AMOUNT"

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var valueSlider: UISlider!
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var tipChoicesTable: UITableView!
    
    @IBAction func doneTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var TIP: [Double] = []
    var SELECTED = 0
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.TIP.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tipChoicesTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = "\(Int(self.TIP[indexPath.row]*100))%"
        
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
        let selectedIndex = tipChoicesTable.indexPathForSelectedRow()
        tipChoicesTable.reloadData()
        tipChoicesTable.selectRowAtIndexPath(selectedIndex, animated: false, scrollPosition: UITableViewScrollPosition.None)
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
        defaultTipControl.selectedSegmentIndex = defaults.integerForKey(kDefaultTipAmount)

        self.tipChoicesTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func save() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(SELECTED, forKey: kDefaultTipAmount)
        defaults.setObject(TIP, forKey: kSegmentSettingsKey)
    }
    
    @IBAction func defaultChanged(sender: AnyObject) {
        SELECTED = defaultTipControl.selectedSegmentIndex
        save()
    }
    
    @IBAction func sliderChanged(sender: AnyObject) {
        if let selectedIndex = tipChoicesTable.indexPathForSelectedRow()?.row {
            TIP[selectedIndex] = Double(valueSlider.value);
        }
        refreshChoices()
        save()
    }
}