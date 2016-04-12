//
//  Expense+CoreDataProperties.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 05/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Expense {

    @NSManaged var desc: String?
    @NSManaged var amount: NSNumber?
    @NSManaged var date: NSDate?
    
    func formattedDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd/MM-YYYY"
        return formatter.stringFromDate(date!)
    }

}
