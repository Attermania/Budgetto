//
//  DAO.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 23/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DAO {
    
    static let instance = DAO()
    
    let managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    func getAllTemplates() -> [Template] {
        do {
            return try managedContext.executeFetchRequest( NSFetchRequest(entityName: "Template") ) as! [Template]
        } catch {}
        
        return []
    }
    
    func getAllMoney() -> [Money] {
        do {
            return try managedContext.executeFetchRequest( NSFetchRequest(entityName: "Money") ) as! [Money]
        } catch {}
        
        return []
    }
    
    func createTemplate() -> Template {
        return NSEntityDescription.insertNewObjectForEntityForName("Template", inManagedObjectContext: managedContext) as! Template
    }
    
    func createIncome() -> Income {
        return NSEntityDescription.insertNewObjectForEntityForName("Income", inManagedObjectContext: managedContext) as! Income
    }
    
    func createExpense() -> Expense {
        return NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: managedContext) as! Expense
    }
    
    func save() {
        do {
            try managedContext.save()
        } catch {}
    }
    
    private init() {}
}