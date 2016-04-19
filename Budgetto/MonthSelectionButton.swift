//
//  MonthSelectionButton.swift
//  Budgetto
//
//  Created by Steffen on 19/04/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class MonthSelectionButton: UIBarButtonItem, UIPickerViewDelegate, UIPickerViewDataSource {
    

    func showMonthPickerView(source: AnyObject) {
        
        if let expensesController = source as? ExpensesController {
            
            let view = expensesController.view
            
            let picker = UIPickerView()
            picker.backgroundColor = UIColor.whiteColor()
            picker.delegate = self
            picker.dataSource = self
            UIApplication.sharedApplication().keyWindow!.addSubview(picker)
            UIApplication.sharedApplication().keyWindow!.bringSubviewToFront(picker)

            picker.translatesAutoresizingMaskIntoConstraints = false
            
            let pinBottom = NSLayoutConstraint(item: picker, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
            let pinLeft = NSLayoutConstraint(item: picker, attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1, constant: -15)
            let pinRight = NSLayoutConstraint(item: picker, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1, constant: 15)
            
            NSLayoutConstraint.activateConstraints([pinBottom, pinLeft, pinRight])

        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "jens er gud"
    }
}
