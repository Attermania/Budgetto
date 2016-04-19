//
//  Money+CoreDataProperties.swift
//  Budgetto
//
//  Created by Thomas Attermann on 19/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Money {

    @NSManaged var amount: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var desc: String?
    
    func formattedDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM-YYYY"
        return formatter.stringFromDate(date!)
    }
    
    func stringToDate(date : String) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM-YYYY"
        return formatter.dateFromString(date)!
    }

}
