//
//  ExpensesController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit
import CoreData

class ExpensesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellSpacingHeight: CGFloat = 5
    
    @IBAction func returnedFromDetailView (segue : UIStoryboardSegue) {
        loadData()
    }
    
    @IBOutlet weak var expensesTableview: UITableView!
    
    let managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    var money = [Money]() {
        didSet {
            self.expensesTableview.reloadData()
        }
    }
    
    func loadData() {
        let request = NSFetchRequest(entityName: "Money")
        
        do {
            let results = try managedContext.executeFetchRequest(request)
            self.money = results as! [Money]
            
        } catch {
            print("error in loading \(error)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expensesTableview.delegate = self
        expensesTableview.dataSource = self
        expensesTableview.separatorColor = UIColor.clearColor()
        
        self.view.setDefaultBackground()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // Number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return money.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! BudgettoCell
        let chosenMoney = money[indexPath.row]
        
        let amount = (chosenMoney.amount?.stringValue != nil ? chosenMoney.amount?.stringValue : "")!
        
//        cell.expense = chosenMoney
//        cell.descLabel.text = expense.desc
//        cell.amountLabel.text = "-" + amount + " kr"
//        cell.dateLabel.text = expense.formattedDate()
        
        if chosenMoney is Expense {
            cell.descLabel.text = chosenMoney.desc
            cell.amountLabel.text = " - " + amount + " kr"
            cell.dateLabel.text = chosenMoney.formattedDate()
        }
        
        if chosenMoney is Income {
            cell.descLabel.text = chosenMoney.desc
            cell.amountLabel.text = " + " + amount + " kr"
            cell.dateLabel.text = chosenMoney.formattedDate()
            let amountInNumbers = Int(amount)
            if amountInNumbers >= 0 {
                cell.amountLabel.textColor = UIColor.greenColor()
            }
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 40
//    }
    

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clearColor()
        
        return v
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! ExpensesDetailViewController

        if segue.identifier == "editExpenseOrIncomeSegue" {
            // Editing an expense
            if money[expensesTableview.indexPathForSelectedRow!.row] is Expense {
                destVC.expenseBeingEdited = money[expensesTableview.indexPathForSelectedRow!.row] as? Expense
                destVC.titleForView = "Rediger Udgift"
            }
            // Editing an income
            if money[expensesTableview.indexPathForSelectedRow!.row] is Income {
                destVC.incomeBeingEdited = money[expensesTableview.indexPathForSelectedRow!.row] as? Income
                destVC.titleForView = "Rediger indtægt"
            }
        }
        // Creating an income
        if segue.identifier == "createIncomeSegue" {
            destVC.incomeBeingCreated = true
            destVC.titleForView = "Opret indtægt"
        }
        // Creating an income
        if segue.identifier == "createExpenseSegue" {
            destVC.expenseBeingCreated = true
            destVC.titleForView = "Opret udgift"
        }
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // numbers.removeAtIndex(indexPath.row)
            // tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

}
