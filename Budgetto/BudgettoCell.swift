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
        setupLayout()
    }
    
    func setupLayout()
    {
        // cell background color with opacity
        self.backgroundColor = UIColor.whiteColor()
        // shadow
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(-1, -1)
        self.layer.shadowOpacity = 1.0
        // margins
        self.preservesSuperviewLayoutMargins = true
        // selection style
        let selectView = UIView()
        selectView.frame.size.width = self.frame.size.width
        selectView.frame.size.height = self.frame.size.height
        selectView.backgroundColor = UIColor(hexString: "#d8dcfe").colorWithAlphaComponent(0.50)
        self.selectedBackgroundView = selectView
    }
    
    override func setNeedsLayout() {
        
    }
    
    override func setNeedsUpdateConstraints() {
        
    }
    
    override func layoutSubviews() {
        

    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
