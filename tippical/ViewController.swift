//
//  ViewController.swift
//  tippical
//
//  Created by Josiah Gaskin on 4/7/15.
//  Copyright (c) 2015 Josiah Gaskin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipField: UITextField!
    @IBOutlet weak var percentControl: UISegmentedControl!
    
    let TIP = [0.15, 0.18, 0.2, 0.25]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func percentChanged(sender: UISegmentedControl, forEvent event: UIEvent) {
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tipAmount = billAmount * TIP[sender.selectedSegmentIndex]
        tipField.text = "\(tipAmount)"
    }
    
}

