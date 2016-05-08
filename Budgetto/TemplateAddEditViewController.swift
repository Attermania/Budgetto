//
//  TemplateAddEditViewController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 06/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit
import CoreData

class TemplateAddEditViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBOutlet weak var textfieldAmount: AmountTextField!
    
    var titleForScene = ""
    
    var dao = DAO.instance
    
    var creatingIncome = false
    var creatingExpense = false
    var editingIncome = false
    var editingExpense = false
    
    var incomeBeingEdited: Income?
    var expenseBeingEdited: Expense?
    
    var templateBeingEdited: Template?
    
    @IBAction func addFinanceButton(sender: AnyObject) {
        let saved = save()
        
        if saved {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func save() -> Bool {
        
        if !validateTextfields() {
            return false
        }
        
        let amount = textfieldAmount.asDouble()!
        
        if creatingIncome == true {
            // Create income and set values from textfields
            let income = dao.createIncome()
            income.desc = descriptionTextfield.text!
            income.amount = amount
            // Connect income to template.
            income.template = templateBeingEdited
        } else if creatingExpense == true {
            // Create expense and set values from textfields
            let expense = dao.createExpense()
            expense.desc = descriptionTextfield.text!
            expense.amount = amount
            // Connect expense to template
            expense.template = templateBeingEdited
            
        } else if editingIncome == true {
            incomeBeingEdited?.desc = descriptionTextfield.text
            incomeBeingEdited?.amount = amount
        } else if editingExpense == true {
            expenseBeingEdited?.desc = descriptionTextfield.text
            expenseBeingEdited?.amount = amount
        }
        
        dao.save()
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title = titleForScene
        
        setupFinance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! TemplateDetailViewController
        destVC.template = templateBeingEdited!
    }
    
    func setupFinance () {
        if expenseBeingEdited != nil {
            descriptionTextfield.text = expenseBeingEdited?.desc
            textfieldAmount.text = String((expenseBeingEdited?.amount)!)
        }
        if incomeBeingEdited != nil {
            descriptionTextfield.text = incomeBeingEdited?.desc
            textfieldAmount.text = String((incomeBeingEdited?.amount)!)
        }
    }
    
    func validateTextfields () -> Bool {
        
        if descriptionTextfield.text == "" || textfieldAmount.asDouble() == nil {
            return true
        }
        
        return true
    }

}
