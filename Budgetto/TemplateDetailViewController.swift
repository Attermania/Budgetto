//
//  TemplateDetailViewController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 05/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class TemplateDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dao = DAO.instance
    
    var template: Template?
    
    var incomes: [Income] = []
    var expenses: [Expense] = []
    
    @IBOutlet weak var incomeTableView: UITableView!
    @IBOutlet weak var expensesTableView: UITableView!
    
    @IBOutlet weak var templateNameTextfield: UITextField!
    
    @IBAction func returnedFromAddEditVC (segue:UIStoryboardSegue) {
        print("Start")
        print(template?.finances)
        dao.update(self.title!, templateToUpdate: template!)

        sortAndPlaceFinances()
        self.expensesTableView.reloadData()
        self.incomeTableView.reloadData()
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        //dao.update(templateNameTextfield.text!)
        if templateNameTextfield.text != "" {
            if dao.getAllTemplates().count == 0 {
                save()
                template = dao.getAllTemplates()[0]
                //self.title = template?.title
                setTitle()
            } else if dao.getAllTemplates().count > 0{
                print("Test")
                template = dao.getAllTemplates()[0]
                dao.update(templateNameTextfield.text!, templateToUpdate: template!)
                setTitle()
                print(dao.getAllTemplates().count)
            }

        }
    }
    
    override func viewDidLoad() {
        
        sortAndPlaceFinances()
        
//        print("Number of finances: \(dao.getAllFinances().count)")
//        
//        print("Number of templates: \(dao.getAllTemplates().count)")
//
//        for finance in dao.getAllFinances() {
//            if finance is Income {
//                print("We got an income")
//            }
//            if finance is Expense {
//                print("We got an expense")
//            }
//        }
        
        incomeTableView.delegate = self
        incomeTableView.dataSource = self
        incomeTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "incomecell")
        expensesTableView.delegate = self
        expensesTableView.dataSource = self
        expensesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "expensecell")
        
        template = dao.getAllTemplates().first
        
        super.viewDidLoad()
        
        self.view.setDefaultBackground()
        
        self.title = template?.title
        
    }
    
    func sortAndPlaceFinances () {
        for finance in dao.getAllFinances() {
            if finance is Income {
                let convertedFinance = finance as! Income
                incomes.append(convertedFinance)
            }
            if finance is Expense {
                let convertedFinance = finance as! Expense
                expenses.append(convertedFinance)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        template = dao.createTemplate()
        template!.title = templateNameTextfield.text
        
        dao.save()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! TemplateAddEditViewController
        destVC.templateBeingEdited = template
        
        if segue.identifier == "createIncome" {
            destVC.titleForScene = "Ny indtægt"
            destVC.creatingIncome = true
            
        } else if segue.identifier == "createExpense" {
            destVC.titleForScene = "Ny udgift"
            destVC.creatingExpense = true
        }
    }
    
    func setTitle () {
        self.title = template?.title
        templateNameTextfield.text = ""
        templateNameTextfield.placeholder = template?.title
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.incomeTableView {
            count = incomes.count
        }
        
        if tableView == self.expensesTableView {
            count = expenses.count
        }
        
        return count!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.incomeTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("incomecell", forIndexPath: indexPath)
            let specificIncome = incomes[indexPath.row]
            cell!.textLabel!.text = specificIncome.desc
            
        }
        
        if tableView == self.expensesTableView {
            cell = tableView.dequeueReusableCellWithIdentifier("expensecell", forIndexPath: indexPath)
            let specificExpense = expenses[indexPath.row]
            cell!.textLabel!.text = specificExpense.desc
            
        }
        
        return cell!
    }


}
