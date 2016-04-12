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
    
    var expenses = [Expense]() {
        didSet {
            self.expensesTableview.reloadData()
        }
    }
    
    func loadData() {
        let request = NSFetchRequest(entityName: "Expense")
        
        do {
            let results = try managedContext.executeFetchRequest(request)
            self.expenses = results as! [Expense]
            
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
        return expenses.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! BudgettoCell
        let expense = expenses[indexPath.row]
        
        let amount = (expense.amount?.stringValue != nil ? expense.amount?.stringValue : "")!
        
        cell.expense = expense
        cell.descLabel.text = expense.desc
        cell.amountLabel.text = "-" + amount + " kr"
        cell.dateLabel.text = expense.formattedDate()
        
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
        if segue.identifier == "editExpenseSegue" {
            let destVC = segue.destinationViewController as! ExpensesDetailViewController
            destVC.expenseBeingEdited = expenses[expensesTableview.indexPathForSelectedRow!.row]
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
