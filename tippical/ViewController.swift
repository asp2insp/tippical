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
    @IBOutlet weak var totalField: UITextField!
    
    let TIP = [0.15, 0.18, 0.2, 0.25]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.textAlignment = .Center
        tipField.textAlignment = .Center
        totalField.textAlignment = .Center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        billField.becomeFirstResponder()
    }

    func recalculateTip() {
        var billText = billField.text
        var billAmount = billText._bridgeToObjectiveC().doubleValue
        var tipAmount = round(billAmount * TIP[percentControl.selectedSegmentIndex] * 100) / 100
        var total = billAmount + tipAmount
        tipField.text = "$\(tipAmount)"
        totalField.text = "$\(total)"

    }
    @IBAction func percentChanged(sender: UISegmentedControl, forEvent event: UIEvent) {
        recalculateTip()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        let prospectiveText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if textField == billField {
            if countElements(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.-").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
            // Don't allow more than 2 decimal places
            if let decimalPos = find(prospectiveText, ".") {
                if distance(decimalPos, prospectiveText.endIndex) >= 4 {
                    result = false
                }
            }
            // Don't allow multiple decimal points
            let scanner = NSScanner(string: prospectiveText)
            result &= scanner.scanDecimal(nil) && scanner.atEnd
        }
        
        return result
    }
    
    @IBAction func billChanged(sender: UITextField) {
        recalculateTip()
    }
}

