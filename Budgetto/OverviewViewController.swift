//
//  ViewController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, ReloadView {
    
    @IBOutlet weak var expensesLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var budgetMonthLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    var totalExpenses = 0.0
    var totalIncome = 0.0
    var selectedMonth = MonthViewController.selectedMonth
    var finances = [Finance]() {
        didSet {
            print(finances.count)
            getTotalExpenses()
            getTotalIncome()
            expensesLabel.text = "\(totalExpenses) kr."
            remainingLabel.text = "+ \(totalIncome-totalExpenses) kr."
            incomeLabel.text = "\(totalIncome) kr."
            budgetMonthLabel.text = "Budget for \((selectedMonth!.date?.month())!)"
            financesBar.percentage = getStatsPercentage()
            financesBar.setNeedsDisplay()
        }
    }
    
    let dao = DAO.instance
    
    @IBOutlet weak var monthSelectionButton: MonthSelectionButton!
    
    @IBAction func didTabMonthSelectionButton(sender: AnyObject) {
        monthSelectionButton.showMonthPickerView(self)
    }
    @IBOutlet weak var financesBar: OverviewBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setDefaultBackground()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        monthSelectionButton = appDelegate.monthSelectionButton
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
    }
    
    func loadData() {
        selectedMonth = MonthViewController.selectedMonth
        self.finances = selectedMonth?.finances?.allObjects as! [Finance]
    }
    
    func reloadView() {
        loadData()
    }
    
    func getTotalExpenses() {
        totalExpenses = 0
        for finance in self.finances {
            if finance is Expense
            {
                totalExpenses += Double(finance.amount!)
            }
        }
    }
    
    func getTotalIncome() {
        totalIncome = 0
        for finance in self.finances {
            if finance is Income
            {
                totalIncome += Double(finance.amount!)
            }
        }
    }
    
    func getStatsPercentage() -> CGFloat {
        let percentage = totalExpenses/totalIncome
        return percentage.isNaN ? CGFloat(0) : CGFloat(totalExpenses/totalIncome)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

