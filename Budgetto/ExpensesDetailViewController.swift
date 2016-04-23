//
//  ExpensesDetailViewController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class ExpensesDetailViewController: UIViewController {
    
    let dao = DAO.instance
    
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    
    @IBAction func textfieldEditingDate(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(ExpensesDetailViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
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
            dateTextfield.text = expenseBeingEdited?.formattedDate()
            
            return
        } else if isEditingIncome() {
            descriptionTextfield.text = incomeBeingEdited?.desc
            amountTextfield.text = incomeBeingEdited?.amount?.stringValue
            title = titleForView
            dateTextfield.text = incomeBeingEdited?.formattedDate()
            
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
        
        if isEditingExpense() {
            expenseBeingEdited!.desc = descriptionTextfield.text
            expenseBeingEdited!.amount = Double(amountTextfield.text!)
            expenseBeingEdited!.date = selectedDate
        } else  if expenseBeingCreated {
            let expense = dao.createExpense()
            expense.desc = descriptionTextfield.text
            expense.amount = Double(amountTextfield.text!)
            expense.date = selectedDate
        }
        
        if isEditingIncome() {
            incomeBeingEdited?.desc = descriptionTextfield.text
            incomeBeingEdited?.amount = Double(amountTextfield.text!)
            incomeBeingEdited?.date = selectedDate
        } else if incomeBeingCreated {
            let income = dao.createIncome()
            income.desc = descriptionTextfield.text
            income.amount = Double(amountTextfield.text!)
            income.date = selectedDate
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
