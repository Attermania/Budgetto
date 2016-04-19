//
//  ExpensesDetailViewController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit
import CoreData

class ExpensesDetailViewController: UIViewController {
    
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
    
    let managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setDefaultBackground()
        
        if isEditingExepense() {
            descriptionTextfield.text = expenseBeingEdited?.desc
            amountTextfield.text = expenseBeingEdited?.amount?.stringValue
            title = titleForView
            dateTextfield.text = expenseBeingEdited?.formattedDate()
        }
        if isEditingIncome() {
            descriptionTextfield.text = incomeBeingEdited?.desc
            amountTextfield.text = incomeBeingEdited?.amount?.stringValue
            title = titleForView
            dateTextfield.text = incomeBeingEdited?.formattedDate()

        }
        if incomeBeingCreated == true {
            title = titleForView
        }
        if expenseBeingCreated == true {
            title = titleForView
        }
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
        
        if isEditingExepense() {
            expenseBeingEdited!.desc = descriptionTextfield.text
            expenseBeingEdited!.amount = Double(amountTextfield.text!)
            expenseBeingEdited!.date = selectedDate
        } else  if expenseBeingCreated == true {
            let expense = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: managedContext) as! Expense
            expense.desc = descriptionTextfield.text
            expense.amount = Double(amountTextfield.text!)
            expense.date = selectedDate
        }
        
        if isEditingIncome() {
            incomeBeingEdited?.desc = descriptionTextfield.text
            incomeBeingEdited?.amount = Double(amountTextfield.text!)
            incomeBeingEdited?.date = selectedDate
        } else if incomeBeingCreated == true {
            let income = NSEntityDescription.insertNewObjectForEntityForName("Income", inManagedObjectContext: managedContext) as! Income
            income.desc = descriptionTextfield.text
            income.amount = Double(amountTextfield.text!)
            income.date = selectedDate
        }
        
        do {
            try managedContext.save()
            print("Saved")
        } catch {}
        
        reset()
    }
    
    func reset() {
        expenseBeingEdited = nil
        
        descriptionTextfield.text = ""
        amountTextfield.text = ""
        dateTextfield.text = ""
    }

    func isEditingExepense() -> Bool {
        return expenseBeingEdited != nil
    }
    
    func isEditingIncome() -> Bool {
        return incomeBeingEdited != nil
    }
    
    func isIncomeBeingCreated() -> Bool {
        return incomeBeingCreated
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
