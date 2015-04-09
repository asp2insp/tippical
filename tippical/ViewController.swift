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
        billField.textAlignment = .Center
        billField.font = billField.font.fontWithSize(55.0)
        tipField.textAlignment = .Center
        
        billField.selectedTextRange = billField.textRangeFromPosition(billField.beginningOfDocument, toPosition: billField.beginningOfDocument)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func recalculateTip() {
        var billText = billField.text
        var billAmount = billText.substringFromIndex(advance(billText.startIndex, 1))._bridgeToObjectiveC().doubleValue
        var tipAmount = billAmount * TIP[percentControl.selectedSegmentIndex]
        tipField.text = "$\(tipAmount)"

    }
    @IBAction func percentChanged(sender: UISegmentedControl, forEvent event: UIEvent) {
        recalculateTip()
    }
    
    @IBAction func billChanged(sender: UITextField) {
        recalculateTip()
    }
}

