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
    
    var finances: [Finance] = []
    
    @IBOutlet weak var financesTableView: UITableView!
    
    @IBOutlet weak var templateNameTextfield: UITextField!
    
    @IBAction func returnedFromAddEditVC (segue:UIStoryboardSegue) {
        print("Start")
        print(template?.finances)
        dao.update(template!)
        sortAndPlaceFinances()
        financesTableView.reloadData()

    }
    
    @IBAction func popover(sender: AnyObject) {
        
        self.performSegueWithIdentifier("showpopover", sender: self)
        
    }
    
    @IBAction func saveButton(sender: AnyObject) {
        if templateNameTextfield.text != "" {
            if dao.getAllTemplates().count == 0 {
                save()
                template = dao.getAllTemplates()[0]
                //self.title = template?.title
            } else if dao.getAllTemplates().count > 0{
                print("Test")
                template = dao.getAllTemplates()[0]
                dao.update(template!)
                print(dao.getAllTemplates().count)
            }

        }
    }
    
    override func viewDidLoad() {
        
        self.title = "Skabelon"
        
        financesTableView.delegate = self
        financesTableView.dataSource = self
        
        if dao.getAllTemplates().count == 0 {
            save()
        } else {
            template = dao.getAllTemplates().first
        }
        
        super.viewDidLoad()
        
        self.view.setDefaultBackground()
        
        sortAndPlaceFinances()
        
    }
    
    func sortAndPlaceFinances () {
        finances.removeAll()
        for finance in dao.getAllFinancesFromTemplate() {
            if finance is Income {
                let convertedFinance = finance as! Income
                finances.append(convertedFinance)
            }
            if finance is Expense {
                let convertedFinance = finance as! Expense
                finances.append(convertedFinance)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        template = dao.createTemplate()
        dao.save()
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
            cell.amountLabel.text = " - " + amount + " kr"
            cell.dateLabel.text = finance.date?.formattedDate()
            cell.amountLabel.textColor = UIColor.redColor()
        }
        
        if finance is Income {
            cell.descLabel.text = finance.desc
            cell.amountLabel.text = " + " + amount + " kr"
            cell.dateLabel.text = finance.date?.formattedDate()
            cell.amountLabel.textColor = UIColor.greenColor()
            
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


}
