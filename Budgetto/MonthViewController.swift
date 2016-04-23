//
//  MonthView.swift
//  Budgetto
//
//  Created by Steffen on 21/04/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class MonthViewController: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    static var selectedMonth: Month?
    
    let dao = DAO.instance
    
    var monthDictionary:[String: [Month]] = [:]
    
    var years: [String] = []
    var months: [[Month]] = []
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
        
        load()
        selectLatestMonth()
    }
    
    func selectLatestMonth() {
        let latestYear = pickerView.numberOfRowsInComponent(0) - 1
        pickerView.selectRow(latestYear, inComponent: 0, animated: false)
        self.pickerView(self.pickerView, didSelectRow: latestYear, inComponent: 0)
        
        let latestMonth = pickerView.numberOfRowsInComponent(1) - 1
        pickerView.selectRow(latestMonth, inComponent: 1, animated: false)
        self.pickerView(self.pickerView, didSelectRow: latestMonth, inComponent: 1)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func load() {
        let months = dao.getAllMonths()
        
        for month in months {
            let date = month.date
            let year = date?.year()
            
            let key = self.monthDictionary.indexForKey(year!)
            
            if(key == nil) {
                self.monthDictionary[year!] = []
            }
            
            self.monthDictionary[year!]?.append(month)
        }
        
        for (key, value) in self.monthDictionary {
            self.years.append(key)
            self.months.append(value)
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.years.count
        }
        
        return self.months[currentYear].count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return years[row]
        }
        return months[currentYear][row].date!.month()
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            currentYear = row
            pickerView.reloadComponent(1)
            MonthViewController.selectedMonth = self.months[currentYear][pickerView.selectedRowInComponent(1)]
        } else if component == 1 {
            MonthViewController.selectedMonth = self.months[currentYear][row]
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
