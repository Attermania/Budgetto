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
    
    var managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    func getAllTemplates() -> [Template] {
        do {
            return try managedContext.executeFetchRequest( NSFetchRequest(entityName: "Template") ) as! [Template]
        } catch {}
        
        return []
    }
    
    func getAllFinances() -> [Finance] {
        do {
            return try managedContext.executeFetchRequest( NSFetchRequest(entityName: "Finance") ) as! [Finance]
        } catch {}
        
        return []
    }
    
    func getAllMonths() -> [Month] {
        
        let request = NSFetchRequest(entityName: "Month")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            return try managedContext.executeFetchRequest( request ) as! [Month]
        } catch {}
        
        return []
    }
    
    func getLatestMonth() -> Month? {
        if (managedContext == nil) {
            managedContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
        }
        
        let request = NSFetchRequest(entityName: "Month")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.fetchLimit = 1
        
        do {
            let results = try managedContext.executeFetchRequest(request)
            
            if results.count > 0 {
                return (results as! [Month])[0]
            }
            
        } catch {
            print("error in loading \(error)")
        }
        
        return nil
    }
    
    func createMonth() -> Month {
        return NSEntityDescription.insertNewObjectForEntityForName("Month", inManagedObjectContext: managedContext) as! Month
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