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
    
    var expenseBeingEdited: Expense?
    var incomeBeingEdited: Income?
    var incomeBeingCreated = false
    var expenseBeingCreated = false
    
    var titleForView = ""
    
    let managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setDefaultBackground()
        
        if isEditingExepense() {
            descriptionTextfield.text = expenseBeingEdited?.desc
            amountTextfield.text = expenseBeingEdited?.amount?.stringValue
            title = titleForView
            //dateTextfield.text = expenseBeingEdited?.formattedDate()
        }
        if isEditingIncome() {
            descriptionTextfield.text = incomeBeingEdited?.desc
            amountTextfield.text = incomeBeingEdited?.amount?.stringValue
            title = titleForView
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
    
    
    func save() {
        
        if isEditingExepense() {
            expenseBeingEdited!.desc = descriptionTextfield.text
            expenseBeingEdited!.amount = Double(amountTextfield.text!)
            //expenseBeingEdited!.date = NSDate()
        } else  if expenseBeingCreated == true {
            let expense = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: managedContext) as! Expense
            expense.desc = descriptionTextfield.text
            expense.amount = Double(amountTextfield.text!)
            //expense.date = NSDate()
        }
        
        if isEditingIncome() {
            incomeBeingEdited?.desc = descriptionTextfield.text
            incomeBeingEdited?.amount = Double(amountTextfield.text!)
        } else if incomeBeingCreated == true {
            let income = NSEntityDescription.insertNewObjectForEntityForName("Income", inManagedObjectContext: managedContext) as! Income
            income.desc = descriptionTextfield.text
            income.amount = Double(amountTextfield.text!)
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
