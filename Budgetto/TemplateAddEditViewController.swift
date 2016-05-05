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
    
    var templateBeingEdited: Template?

    @IBAction func addFinanceButton(sender: AnyObject) {
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

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setDefaultBackground()

        self.title = titleForScene
        
        print(templateBeingEdited)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! TemplateDetailViewController
        destVC.template = templateBeingEdited
    }


}
