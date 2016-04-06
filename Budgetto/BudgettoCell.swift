//
//  BudgettoCell.swift
//  Budgetto
//
//  Created by Steffen on 05/04/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class BudgettoCell: UITableViewCell {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setupLayout()

    }
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
        print("init method")
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
        print("setNeedsLayout")

    }
    
    override func setNeedsUpdateConstraints() {
        print("testing")
    }
    
    override func layoutSubviews() {
        print("layoutSubviews method")

    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
