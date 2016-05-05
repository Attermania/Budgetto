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
                dao.update(template!)
                setTitle()
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


}
