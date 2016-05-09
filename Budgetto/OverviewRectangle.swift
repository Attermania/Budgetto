//
//  OverviewRectangle.swift
//  Budgetto
//
//  Created by Steffen on 09/05/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class OverviewRectangle: UIView {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let colorTop = UIColor(hexString: "#9DD989")
        let colorBottom = UIColor(hexString: "#66B34E")
        let colorSpc = CGColorSpaceCreateDeviceRGB();
        let gradient = CGGradientCreateWithColors(colorSpc, [colorTop.CGColor, colorBottom.CGColor], [0.0, 1.0])
        
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0.5, 0.0), CGPointMake(0.5, rect.size.height), .DrawsAfterEndLocation)
        
        // text shadow
        amountLabel.layer.shadowRadius = 2
        amountLabel.layer.shadowOpacity = 0.2
        amountLabel.layer.shadowOffset = CGSizeMake(0.5, 1.0)
    }
    

}
