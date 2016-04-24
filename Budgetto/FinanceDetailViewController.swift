//
//  ExpensesDetailViewController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class FinanceDetailViewController: UIViewController {
    
    let dao = DAO.instance
    
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    
    @IBAction func amountTextFieldDidChange(sender: AnyObject) {
        formatAmount()
    }
    
    private func formatAmount() {
        if amountTextfield.text == nil || amountTextfield.text == "" {
            return
        }
        
        let textFieldText = amountTextfield.text!.stringByReplacingOccurrencesOfString(
            ".",
            withString: ""
        )
        
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let formattedOutput = formatter.stringFromNumber(Int(textFieldText)!)
        
        amountTextfield.text = formattedOutput
    }
    
    @IBAction func textfieldEditingDate(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(FinanceDetailViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    var expenseBeingEdited: Expense?
    var incomeBeingEdited: Income?
    var incomeBeingCreated = false
    var expenseBeingCreated = false
    
    var titleForView = ""
    
    var selectedDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setDefaultBackground()
        
        if isEditingExpense() {
            descriptionTextfield.text = expenseBeingEdited?.desc
            amountTextfield.text = expenseBeingEdited?.amount?.stringValue
            title = titleForView
            dateTextfield.text = expenseBeingEdited?.date?.formattedDate()
            
            formatAmount()
            
            return
        } else if isEditingIncome() {
            descriptionTextfield.text = incomeBeingEdited?.desc
            amountTextfield.text = incomeBeingEdited?.amount?.stringValue
            title = titleForView
            dateTextfield.text = incomeBeingEdited?.date?.formattedDate()
            
            formatAmount()
            
            return
        }
        
        dateTextfield.text = NSDate().formattedDate()
        title = titleForView
    }
    
    @IBAction func didTapSave(sender: AnyObject) {
        save()
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        let date: NSDate = NSDate()
        
        dateFormatter.dateFormat = "dd/MM-YYYY"
        
        dateFormatter.stringFromDate(date)
        
        dateTextfield.text = dateFormatter.stringFromDate(sender.date)
        
        selectedDate = sender.date
        
    }
    
    
    func save() {
        let amount = Double( amountTextfield.text!.stringByReplacingOccurrencesOfString(".", withString: "") )
        
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

}
