//
//  OverviewBar.swift
//  Budgetto
//
//  Created by Steffen on 01/05/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class OverviewBar: UIView {
    
    var percentage: CGFloat = 0
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(rect: rect)
            
        let boundingBox = CGPathGetBoundingBox(path.CGPath)
        let expenseBox = CGRectMake(boundingBox.origin.x, boundingBox.origin.y, boundingBox.size.width * percentage, boundingBox.size.height)
        let incomeBox = CGRectMake(boundingBox.origin.x, boundingBox.origin.y, boundingBox.size.width, boundingBox.size.height)
        
        UIColor.greenColor().setFill()
        UIRectFill(incomeBox)
        UIColor.redColor().setFill()
        UIRectFill(expenseBox)
        
    }
    
    
    
}
