//
//  Money+CoreDataProperties.swift
//  Budgetto
//
//  Created by Thomas Attermann on 18/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Money {

    @NSManaged var desc: String?
    @NSManaged var amount: NSNumber?
    @NSManaged var date: String?

}
