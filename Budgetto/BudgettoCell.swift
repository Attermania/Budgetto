//
//  BudgettoCell.swift
//  Budgetto
//
//  Created by Steffen on 05/04/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class BudgettoCell: UITableViewCell {
    
    var expense: Expense?
    var income: Income?
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
        self.backgroundColor = UIColor.whiteColor()
    }

}
