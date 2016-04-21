//
//  TemplateDetailViewController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 05/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit
import CoreData

class TemplateDetailViewController: UIViewController {
    
    let managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext

    var createNewTemplate = false
    
    //var temporaryTemplate = nil
    
    @IBOutlet weak var templateNameTextfield: UITextField!
    
    var templateBeingEdited: Template?
    
    var titleForWindow = ""
    
    @IBAction func returnedFromAddEditVC (segue:UIStoryboardSegue) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.setDefaultBackground()
        
        self.title = titleForWindow
        
        templateNameTextfield.text = templateBeingEdited?.title
        
        print(createNewTemplate)
        
        if createNewTemplate == true {
                //temporaryTemplate =
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        
        let income = NSEntityDescription.insertNewObjectForEntityForName("Template", inManagedObjectContext: managedContext) as! Template
        income.title = templateNameTextfield.text
        
        do {
            try managedContext.save()
            print("Saved")
        } catch {}
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        save()
    }


}
