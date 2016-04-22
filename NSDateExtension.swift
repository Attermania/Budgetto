//
//  NSDateExtension.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 22/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import Foundation

extension NSDate {
    
    func formattedDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM-YYYY"
        return formatter.stringFromDate(self)
    }
    
    static func stringToDate(date : String) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM-YYYY"
        return formatter.dateFromString(date)!
    }
    
}