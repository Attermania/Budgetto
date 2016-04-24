//
//  Month+CoreDataProperties.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 24/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Month {

    @NSManaged var date: NSDate?
    @NSManaged var finances: NSSet?

}
