//
//  Finance+CoreDataProperties.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 23/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Finance {

    @NSManaged var amount: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var desc: String?
    @NSManaged var template: Template?
    @NSManaged var month: Month?

}
