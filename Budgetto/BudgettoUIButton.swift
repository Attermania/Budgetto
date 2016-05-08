//
//  BudgettoUIButton.swift
//  Budgetto
//
//  Created by Thomas Attermann on 08/05/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class BudgettoUIButton: UIButton {
    
    var fontSize: CGFloat = 14
    var padding: CGFloat = 10
    var borderSize: CGFloat = 1
    
    override var highlighted: Bool {
        didSet {
            if highlighted {
                self.layer.masksToBounds = true;
                self.layer.shadowRadius = 5;
                self.layer.shadowOpacity = 0.1;
                let indent: CGFloat = 5;
                let innerRect = CGRectMake(indent,indent,self.frame.size.width-2*indent,5);
                self.layer.shadowPath = UIBezierPath(rect: innerRect).CGPath
            } else {
                self.layer.shadowPath = nil
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Set normal title with attributes
        let title = self.titleForState(.Normal)?.uppercaseString
        let attributedTitle = NSAttributedString(string: title!, attributes: [
            NSKernAttributeName: 2.0,
            NSForegroundColorAttributeName: UIColor(hexString: "#555555").colorWithAlphaComponent(1),
            NSFontAttributeName: UIFont.systemFontOfSize(fontSize)
        ])
        
        self.setAttributedTitle(attributedTitle, forState: .Normal)
        self.setAttributedTitle(attributedTitle, forState: .Highlighted)
        
        // Border width + color 
        self.layer.borderWidth = borderSize
        self.layer.borderColor = UIColor(hexString: "#9DD989").CGColor
        
        // Padding
        self.contentEdgeInsets = UIEdgeInsetsMake(padding, 0, padding, 0);
        
        // Rounded corners - computed
        self.layer.cornerRadius = ( fontSize + (padding * 2) + (borderSize * 2) ) / 2
    }
    
}
