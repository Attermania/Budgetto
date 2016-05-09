//
//  ViewController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, ReloadView {
    
    @IBOutlet weak var remainingLabelUnderBar: UILabel!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var disposableFinancesLabel: UILabel!
    @IBOutlet weak var dayRect: OverviewRectangle!
    @IBOutlet weak var monthRect: OverviewRectangle!
    @IBOutlet weak var weekRect: OverviewRectangle!
    @IBOutlet weak var averageUsedLabel: UILabel!
    @IBOutlet weak var expensesLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var budgetMonthLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    var totalExpenses = 0.0
    var totalIncome = 0.0
    var selectedMonth = MonthViewController.selectedMonth
    let calendar = NSCalendar.currentCalendar()
    var finances = [Finance]() {
        didSet {
            print(finances.count)
            getTotalExpenses()
            getTotalIncome()
            setupLabels()
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
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        monthSelectionButton = appDelegate.monthSelectionButton
        // letter spacing
        disposableFinancesLabel.addTextSpacing(5)
        usedLabel.addTextSpacing(2.0)
        remainingLabelUnderBar.addTextSpacing(2.0)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        loadData()
    }
    
    func loadData() {
        selectedMonth = MonthViewController.selectedMonth
        
        if(selectedMonth != nil) {
            self.finances = dao.getAllFinancesInMonth(selectedMonth!)
        }
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
    
    func getDailySpent() -> Int {

        let days = calendar.component(.Day, fromDate: NSDate())
        return Int(totalExpenses)/days
        
    }
    
    func getAmountToSpendDaily() -> Int {
        
        let pastDays = calendar.component(.Day, fromDate: NSDate())
        let days = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: selectedMonth!.date!)
        let remainingDays = days.length-pastDays
        
        return (Int(totalIncome-totalExpenses))/remainingDays
    }
    
    func getStatsPercentage() -> CGFloat {
        let percentage = totalExpenses/totalIncome
        return percentage.isNaN ? CGFloat(0) : CGFloat(totalExpenses/totalIncome)
    }
    
    func setupLabels() {
        
        // top labels
        expensesLabel.text = "\(Int(totalExpenses))"
        let remainingAmount = Int(totalIncome-totalExpenses)
        remainingAmount > 0 ? (remainingLabel.text = "\(remainingAmount)") : (remainingLabel.text = " \(remainingAmount)")
        incomeLabel.text = "\(Int(totalIncome))"
        budgetMonthLabel.text = "Budget for \((selectedMonth!.date?.month())!)"
        
        // disposable labels
        monthRect.amountLabel.text = "\(Int(totalIncome-totalExpenses)) kr."
        weekRect.amountLabel.text = "\(getAmountToSpendDaily()*7) kr."
        dayRect.amountLabel.text = "\(getAmountToSpendDaily()) kr."
        
        // average label
        averageUsedLabel.text = "Du har i gennemsnit brugt \(getDailySpent()) kroner hver dag denne måned."
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

