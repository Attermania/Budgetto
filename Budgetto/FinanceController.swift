//
//  ExpensesController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class FinanceController: UIViewController, UITableViewDelegate, UITableViewDataSource, ReloadView {

    let dao = DAO.instance
    
    @IBOutlet weak var monthSelectionButton: MonthSelectionButton!
    
    @IBAction func didTapMonthSelectionButton(sender: AnyObject) {
        monthSelectionButton.showMonthPickerView(self)
    }
    
    let cellSpacingHeight: CGFloat = 5
    
    @IBAction func returnedFromDetailView (segue : UIStoryboardSegue) {
        loadData()
    }
    
    @IBOutlet weak var expensesTableview: UITableView!
    
    var finances = [Finance]() {
        didSet {
            self.expensesTableview.reloadData()
        }
    }
    
    func loadData() {
        let month = MonthViewController.selectedMonth
        
        if month != nil {
            self.finances = dao.getAllFinancesInMonth(month!)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        monthSelectionButton = appDelegate.monthSelectionButton
        
        expensesTableview.delegate = self
        expensesTableview.dataSource = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
    }
    
    func reloadView() {
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // Number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finances.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! BudgettoCell
        let finance = finances[indexPath.row]
        
        let amount = (finance.amount?.stringValue != nil ? finance.amount?.stringValue : "")!
        
        if finance is Expense {
            cell.descLabel.text = finance.desc
            cell.amountLabel.text = "- " + formatAmount(amount)
            cell.dateLabel.text = finance.date?.formattedDate()
            cell.amountLabel.textColor = UIColor.redColor()
        }
        
        if finance is Income {
            cell.descLabel.text = finance.desc
            cell.amountLabel.text = "+ " + formatAmount(amount)
            cell.dateLabel.text = finance.date?.formattedDate()
            cell.amountLabel.textColor = UIColor(hexString: "#66B34E")
            
        }
        
        return cell
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clearColor()
        
        return v
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! FinanceDetailViewController

        if segue.identifier == "editExpenseOrIncomeSegue" {
            // Editing an expense
            if finances[expensesTableview.indexPathForSelectedRow!.row] is Expense {
                destVC.expenseBeingEdited = finances[expensesTableview.indexPathForSelectedRow!.row] as? Expense
                destVC.titleForView = "Rediger Udgift"
            }
            // Editing an income
            if finances[expensesTableview.indexPathForSelectedRow!.row] is Income {
                destVC.incomeBeingEdited = finances[expensesTableview.indexPathForSelectedRow!.row] as? Income
                destVC.titleForView = "Rediger indtægt"
            }
        }
        // Creating an income
        else if segue.identifier == "createIncomeSegue" {
            destVC.incomeBeingCreated = true
            destVC.titleForView = "Opret indtægt"
        }
        // Creating an income
        else if segue.identifier == "createExpenseSegue" {
            destVC.expenseBeingCreated = true
            destVC.titleForView = "Opret udgift"
        }
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let finance = finances[indexPath.row]
            
            // Remove from tableview
            finances.removeAtIndex(indexPath.row)
            
            // Delete from coredata
            dao.deleteFinance(finance)
        }
    }

}
