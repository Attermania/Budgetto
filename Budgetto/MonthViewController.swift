//
//  MonthView.swift
//  Budgetto
//
//  Created by Steffen on 21/04/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class MonthView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var years = [2014, 2016]
    var months:[[String]] = [["Januar","Marts"], ["Januar", "Marts", "Maj", "Juni", "December"]]
    var currentYear = 0
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func addMonth(sender: AnyObject) {
        
    }
    
    @IBAction func didSelectDone(sender: AnyObject) {
        self.hidden = true
        MonthSelectionButton.isVisible = false
    }
    
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MonthView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return years.count
        }
        
        return months[currentYear].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(years[row])
        }
        
        return months[currentYear][row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentYear = row
            pickerView.reloadComponent(1)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
