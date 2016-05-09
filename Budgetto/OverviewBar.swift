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
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rect.size.height/2-1)
        path.addClip()
        path.usesEvenOddFillRule = true
        // border
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.CGPath
        borderLayer.fillColor = UIColor.clearColor().CGColor
        borderLayer.strokeColor = UIColor(hexString: "#66B34E").CGColor
        borderLayer.lineWidth = 1
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
        
        let boundingBox = CGPathGetBoundingBox(path.CGPath)
        let expenseBox = CGRectMake(boundingBox.origin.x, boundingBox.origin.y, boundingBox.size.width * percentage, boundingBox.size.height)
        let incomeBox = CGRectMake(boundingBox.origin.x, boundingBox.origin.y, boundingBox.size.width, boundingBox.size.height)
        
        // gradientlayer
        let colorTop = UIColor(hexString: "#FF6060")
        let colorBottom = UIColor(hexString: "#FE3232")
        let colorSpc = CGColorSpaceCreateDeviceRGB();
        let gradient = CGGradientCreateWithColors(colorSpc, [colorTop.CGColor, colorBottom.CGColor], [0.0, 1.0])
        
        // draw income
//        UIColor(hexString: "#7BBF65").setFill()
//        CGContextFillRect(context, incomeBox)
        
        
        // draw expenses
        CGContextAddRect(context, expenseBox)
        CGContextClip(context)
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0.5, 0.0), CGPointMake(0.5, expenseBox.size.height), .DrawsAfterEndLocation)
    }
    
    
    
}
