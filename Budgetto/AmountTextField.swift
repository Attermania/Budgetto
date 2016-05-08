//
//  AmountTextField.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 08/05/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class AmountTextField: UITextField {
    
    let charSet = NSCharacterSet(charactersInString: "0123456789").invertedSet
    
    var isFormatting = false
    
    override var text: String? {
        didSet {
            if !isFormatting {
                editingChanged(self)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addTarget(self, action: #selector(AmountTextField.editingChanged(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    func editingChanged(sender: AnyObject) {
        isFormatting = true
        
        // Remove everything that is not a digit from the amount
        var amountText = self.text?.componentsSeparatedByCharactersInSet(charSet).joinWithSeparator("")
        
        // If there is nothing in the textfield, we can silently return
        if amountText == nil || amountText == "" {
            self.text = ""
            return
        }
        
        // Remove anything over 6 digits
        amountText = amountText?.characters.count > 6 ? amountText?.substringToIndex(amountText!.startIndex.advancedBy(6)) : amountText
        
        // Format thousands with seperator
        let formatter:NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let formattedOutput = formatter.stringFromNumber(Int(amountText!)!)
        
        self.text = formattedOutput
        
        isFormatting = false
    }
    
    func asDouble() -> Double? {
        let amount = self.text?.componentsSeparatedByCharactersInSet(charSet).joinWithSeparator("")
        
        if(amount == nil) {
            return nil
        }
        
        return Double(amount!)
    }

}
