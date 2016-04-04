//
//  UIViewExtension.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

extension UIView {
    
    func setDefaultBackground() {
        let colorTop = UIColor(hexString: "#8D9AFC").CGColor as CGColorRef
        let colorBottom = UIColor(hexString: "#498AC3").CGColor as CGColorRef
        let gl = CAGradientLayer()
        
        // Set background gradient
        gl.frame = self.bounds
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        
        self.layer.insertSublayer(gl, atIndex: 0)
    }
    
}
