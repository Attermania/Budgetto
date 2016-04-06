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
    
    var tableView = UITableView()
    
    let managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    var expenses = [Expense]() {
        didSet {
            self.tableView.reloadData()
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
        
        
        for expense in expenses {
            print(expense.amount)
            print(expense.desc)
            print(expense.date)
            print()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expensesTableview.delegate = self
        expensesTableview.dataSource = self
        // hides the default borders of the cells
        expensesTableview.separatorColor = UIColor.clearColor()
        //expensesTableview.registerClass(BudgettoCell.self, forCellReuseIdentifier: "cell1")
        
        self.view.setDefaultBackground()
        loadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // Number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! BudgettoCell
        
        

        //print(cell)
        
        
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
        if segue.identifier == "createExpenseSegue" {
            // let destVC = segue.destinationViewController as! ExpensesDetailViewController
            
            print("Ny Udgift")
        }
        if segue.identifier == "editExpenseSegue" {
            let destVC = segue.destinationViewController as! ExpensesDetailViewController
            destVC.expenseBeingEdited = expenses[0]
            
            print("Rediger Udgift")
        }
        
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
