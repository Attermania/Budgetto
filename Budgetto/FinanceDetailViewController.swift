//
//  ExpensesDetailViewController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class FinanceDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let dao = DAO.instance
    
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBOutlet weak var amountTextfield: AmountTextField!
    @IBOutlet weak var dateTextfield: UITextField!
    let datePickerView:UIPickerView = UIPickerView()
    let calendar = NSCalendar.currentCalendar()
    let currentDate = MonthViewController.selectedMonth?.date
    var daysArr = [String]()
    
    @IBAction func textfieldEditingDate(sender: UITextField) {
        
        sender.inputView = datePickerView
        // select the current day in the pickerview
        let strDate = dateTextfield.text
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        dateFormatter.dateFormat = "dd/MM-yyyy"
        let newDate = dateFormatter.dateFromString(strDate!)
        let components = calendar.components([.Day], fromDate: newDate!)
        let day = components.day
        let index = daysArr.indexOf(String(day))
        
        datePickerView.selectRow(index!, inComponent: 0, animated: false)

    }
    
    var expenseBeingEdited: Expense?
    var incomeBeingEdited: Income?
    var incomeBeingCreated = false
    var expenseBeingCreated = false
    
    var titleForView = ""
    
    var selectedDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerView.delegate = self
        datePickerView.dataSource = self
        createDaysArray()
        calendar.timeZone = NSTimeZone(name: "UTC")!

        
        if isEditingExpense() {
            descriptionTextfield.text = expenseBeingEdited?.desc
            amountTextfield.text = expenseBeingEdited?.amount?.stringValue
            title = titleForView
            dateTextfield.text = expenseBeingEdited?.date?.formattedDate()
            selectedDate = (expenseBeingEdited?.date)!
            
            return
        } else if isEditingIncome() {
            descriptionTextfield.text = incomeBeingEdited?.desc
            amountTextfield.text = incomeBeingEdited?.amount?.stringValue
            title = titleForView
            dateTextfield.text = incomeBeingEdited?.date?.formattedDate()
            selectedDate = (incomeBeingEdited?.date)!
            
            return
        }
        
        dateTextfield.text = NSDate().formattedDate()
        title = titleForView
    }
    
    @IBAction func didTapSave(sender: AnyObject) {
        let saved = save()
        
        if saved {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        let date: NSDate = NSDate()
        
        dateFormatter.dateFormat = "dd/MM-YYYY"
        
        dateFormatter.stringFromDate(date)
        
        dateTextfield.text = dateFormatter.stringFromDate(sender.date)
        
        selectedDate = sender.date
        
    }
    
    func validForSaving() -> Bool {
        if descriptionTextfield.text == nil || descriptionTextfield.text == "" || amountTextfield.asDouble() == nil {
            return false
        }
        
        return true
    }
    
    
    func save() -> Bool {
        if !validForSaving() {
            return false
        }
        
        // Remove everything that is not a digit from the amount
        let amount = Double( (amountTextfield.text?.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator(""))! )
        
        if isEditingExpense() {
            expenseBeingEdited!.desc = descriptionTextfield.text
            expenseBeingEdited!.amount = amount
            expenseBeingEdited!.date = selectedDate
        } else  if expenseBeingCreated {
            let expense = dao.createExpense()
            expense.desc = descriptionTextfield.text
            expense.amount = amount
            expense.date = selectedDate
            expense.month = MonthViewController.selectedMonth
        }
        
        if isEditingIncome() {
            incomeBeingEdited?.desc = descriptionTextfield.text
            incomeBeingEdited?.amount = amount
            incomeBeingEdited?.date = selectedDate
        } else if incomeBeingCreated {
            let income = dao.createIncome()
            income.desc = descriptionTextfield.text
            income.amount = amount
            income.date = selectedDate
            income.month = MonthViewController.selectedMonth
        }
        
        dao.save()
        
        reset()
        
        return true
    }
    
    func reset() {
        expenseBeingEdited = nil
        
        descriptionTextfield.text = ""
        amountTextfield.text = ""
        dateTextfield.text = ""
    }

    func isEditingExpense() -> Bool {
        return expenseBeingEdited != nil
    }
    
    func isEditingIncome() -> Bool {
        return incomeBeingEdited != nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createDaysArray() {
        
        let days = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: currentDate!)
        
        for day in days.toRange()! {
            self.daysArr.append(String(day))
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let days = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: currentDate!)
        
        return days.length
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return daysArr[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedDay = daysArr[row]
        let components = calendar.components([.Day, .Month, .Year], fromDate: currentDate!)
        // set the selected day
        components.day = Int(selectedDay)!
        
        selectedDate = calendar.dateFromComponents(components)!
        
        dateTextfield.text = selectedDate.formattedDate()
        
    }

}
