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
    @IBOutlet weak var textfieldAmount: UITextField!
    
    var titleForScene = ""
    
    var dao = DAO.instance
    
    var creatingIncome = false
    var creatingExpense = false
    var editingIncome = false
    var editingExpense = false
    
    var incomeBeingEdited: Income?
    var expenseBeingEdited: Expense?
    
    var templateBeingEdited: Template?

    @IBAction func amountEditingChanged(sender: AnyObject) {
        formatAmount()
    }
    
    @IBAction func addFinanceButton(sender: AnyObject) {
        if validateTextfields() != false {
            if creatingIncome == true {
                // Create income and set values from textfields
                let income = dao.createIncome()
                income.desc = descriptionTextfield.text!
                income.amount = Double(textfieldAmount.text!)
                // Connect income to template.
                income.template = templateBeingEdited
                
                
            } else if creatingExpense == true {
                // Create expense and set values from textfields
                let expense = dao.createExpense()
                expense.desc = descriptionTextfield.text!
                expense.amount = Double(textfieldAmount.text!)
                // Connect expense to template
                expense.template = templateBeingEdited
                
            } else if editingIncome == true {
                incomeBeingEdited?.desc = descriptionTextfield.text
                incomeBeingEdited?.amount = Double(textfieldAmount.text!)
                dao.save()
            } else if editingExpense == true {
                expenseBeingEdited?.desc = descriptionTextfield.text
                expenseBeingEdited?.amount = Double(textfieldAmount.text!)
                dao.save()
            }

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setDefaultBackground()

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
        var allFieldsAreSet = false
        if descriptionTextfield.text != "" && textfieldAmount.text != "" {
            allFieldsAreSet = true
        }
        return allFieldsAreSet
    }
    
    private func formatAmount() {
        // If there is nothing in the textfield, we can silently return
        if textfieldAmount.text == nil || textfieldAmount.text == "" {
            return
        }
        
        // Remove everything that is not a digit from the amount
        var textFieldText = textfieldAmount.text?.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        
        // Remove anything over 6 digits
        textFieldText = textFieldText?.characters.count > 6 ? textFieldText?.substringToIndex(textFieldText!.startIndex.advancedBy(6)) : textFieldText
        
        // Format thousands with seperator
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let formattedOutput = formatter.stringFromNumber(Int(textFieldText!)!)
        
        textfieldAmount.text = formattedOutput
    }


}
