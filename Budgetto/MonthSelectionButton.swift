//
//  MonthSelectionButton.swift
//  Budgetto
//
//  Created by Steffen on 19/04/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class MonthSelectionButton: UIBarButtonItem, UIPickerViewDelegate, UIPickerViewDataSource {
    
    static var monthSelectionView: MonthViewController?
    static var isVisible = false

    func showMonthPickerView(source: AnyObject) {
        
        if MonthSelectionButton.monthSelectionView == nil {
            
            let keyWindow = UIApplication.sharedApplication().keyWindow
            MonthSelectionButton.monthSelectionView = MonthViewController.instanceFromNib() as? MonthViewController
            
            UIApplication.sharedApplication().keyWindow?.addSubview(MonthSelectionButton.monthSelectionView!)
            UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(MonthSelectionButton.monthSelectionView!)
            
            MonthSelectionButton.monthSelectionView!.translatesAutoresizingMaskIntoConstraints = false
            
            let heightConstraint = NSLayoutConstraint(item: MonthSelectionButton.monthSelectionView!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 200)
            let pinBottom = NSLayoutConstraint(item: MonthSelectionButton.monthSelectionView!, attribute: .Bottom, relatedBy: .Equal, toItem: keyWindow, attribute: .Bottom, multiplier: 1, constant: 0)
            let pinLeft = NSLayoutConstraint(item: MonthSelectionButton.monthSelectionView!, attribute: .LeadingMargin, relatedBy: .Equal, toItem: keyWindow, attribute: .LeadingMargin, multiplier: 1, constant: 0)
            let pinRight = NSLayoutConstraint(item: MonthSelectionButton.monthSelectionView!, attribute: .TrailingMargin, relatedBy: .Equal, toItem: keyWindow, attribute: .TrailingMargin, multiplier: 1, constant: 0)
            
            NSLayoutConstraint.activateConstraints([pinBottom, pinLeft, pinRight, heightConstraint])
            MonthSelectionButton.isVisible = true
            
            // Set the current view
            MonthSelectionButton.monthSelectionView?.currentView = source as? ReloadView
            
            return
        }
        
        // Set the current view
        MonthSelectionButton.monthSelectionView?.currentView = source as? ReloadView
        
        if MonthSelectionButton.isVisible {
            MonthSelectionButton.monthSelectionView?.hidden = true
            MonthSelectionButton.isVisible = false
            (source as? ReloadView)?.reloadView()
        }
        else {
            MonthSelectionButton.monthSelectionView?.hidden = false
            MonthSelectionButton.isVisible = true
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
