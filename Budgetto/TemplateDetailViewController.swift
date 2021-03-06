//
//  TemplateDetailViewController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 05/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class TemplateDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    
    let dao = DAO.instance
    
    var template: Template?

    
    @IBAction func popover(sender: AnyObject) {
        self.performSegueWithIdentifier("showpopover", sender: self)
    }
    
    var finances: [Finance] = [] {
        didSet {
            self.financesTableView.reloadData()
        }
    }
    
    @IBOutlet weak var financesTableView: UITableView!
    
    override func viewDidLoad() {
        
        self.title = "Skabelon"
        
        financesTableView.delegate = self
        financesTableView.dataSource = self
        
        createTemplateIfNonExistant()
        
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.finances = dao.getAllFinancesFromTemplate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTemplateIfNonExistant() {
        
        if dao.getAllTemplates().count == 0 {
            template = dao.createTemplate()
            dao.save()
        } else {
            template = dao.getAllTemplates().first
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showpopover" {
            let vc = segue.destinationViewController as UIViewController
            let contoller = vc.popoverPresentationController
            if contoller != nil {
                contoller?.delegate = self
            }
        }
        
        if segue.identifier == "createIncome" || segue.identifier == "createExpense" || segue.identifier == "editFinanceSegue" {
            let destVC = segue.destinationViewController as! TemplateAddEditViewController
        
            if segue.identifier == "createIncome" {
            destVC.titleForScene = "Ny indtægt"
            destVC.creatingIncome = true
            destVC.templateBeingEdited = template

            
        } else if segue.identifier == "createExpense" {
            destVC.titleForScene = "Ny udgift"
            destVC.creatingExpense = true
            destVC.templateBeingEdited = template

                
        } else if segue.identifier == "editFinanceSegue" {
                
                destVC.templateBeingEdited = template
                
                if finances[(financesTableView.indexPathForSelectedRow?.row)!] is Expense {
                destVC.expenseBeingEdited = finances[(financesTableView.indexPathForSelectedRow?.row)!] as? Expense
                destVC.titleForScene = "Rediger udgift"
                destVC.editingExpense = true
                }
                if finances[(financesTableView.indexPathForSelectedRow?.row)!] is Income {
                destVC.incomeBeingEdited = finances[(financesTableView.indexPathForSelectedRow?.row)!] as? Income
                destVC.titleForScene = "Rediger indtægt"
                destVC.editingIncome = true
                }
            
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finances.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("financecell", forIndexPath: indexPath) as! BudgettoCell
        let finance = finances[indexPath.row]
        
        let amount = (finance.amount?.stringValue != nil ? finance.amount?.stringValue : "")!

        if finance is Expense {
            cell.descLabel.text = finance.desc
            cell.amountLabel.text = " - " + formatAmount(amount)
            cell.amountLabel.textColor = UIColor(hexString: "#FE4040")
        }
        
        if finance is Income {
            cell.descLabel.text = finance.desc
            cell.amountLabel.text = " + " + formatAmount(amount)
            cell.amountLabel.textColor = UIColor(hexString: "#75BA5F")
            
        }
        
        return cell

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let finance = finances[indexPath.row]
            
            // Remove from tableview
            finances.removeAtIndex(indexPath.row)
            
            // Delete from coredata
            dao.deleteFinance(finance)
            
            financesTableView.reloadData()
        }
    }
    
    private func formatAmount(amount: String?) -> String {
        let charSet = NSCharacterSet(charactersInString: "0123456789").invertedSet
        
        // Remove everything that is not a digit from the amount
        var amountText = amount?.componentsSeparatedByCharactersInSet(charSet).joinWithSeparator("")
        
        // If there is nothing in the textfield, we can silently return
        if amountText == nil || amountText == "" {
            return ""
        }
        
        // Remove anything over 6 digits
        amountText = amountText?.characters.count > 6 ? amountText?.substringToIndex(amountText!.startIndex.advancedBy(6)) : amountText
        
        // Format thousands with seperator
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let formattedOutput = formatter.stringFromNumber(Int(amountText!)!)
        
        return formattedOutput!
    }


}
