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
    
    let managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setDefaultBackground()
        
        if(isEditingExepense()) {
            descriptionTextfield.text = expenseBeingEdited?.desc
            amountTextfield.text = expenseBeingEdited?.amount?.stringValue
            dateTextfield.text = expenseBeingEdited?.formattedDate()
        }
    }
    
    @IBAction func didTapSave(sender: AnyObject) {
        save()
    }
    
    
    func save() {
        
        if isEditingExepense() {
            expenseBeingEdited!.desc = descriptionTextfield.text
            expenseBeingEdited!.amount = Double(amountTextfield.text!)
            expenseBeingEdited!.date = NSDate()
        } else {
            let expense = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: managedContext) as! Expense
            expense.desc = descriptionTextfield.text
            expense.amount = Double(amountTextfield.text!)
            expense.date = NSDate()
        }
        
        do {
            try managedContext.save()
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
