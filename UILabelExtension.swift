//
//  UILabelExtension.swift
//  Budgetto
//
//  Created by Steffen on 09/05/16.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

extension UILabel{
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: self.text!.characters.count))
        self.attributedText = attributedString
    }
}