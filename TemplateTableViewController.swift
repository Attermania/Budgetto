//
//  TemplateTableViewController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 05/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit
import CoreData

class TemplateTableViewController: UITableViewController {
    
    @IBOutlet var templateTableview: UITableView!
    
    let managedContext: NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    var templates = [Template]() {
        didSet {
            self.templateTableview.reloadData()
        }
    }
    
    @IBAction func returnedFromTemplateDetailVC (segue:UIStoryboardSegue) {
        self.loadData()
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        templateTableview.delegate = self
        templateTableview.dataSource = self

        self.view.setDefaultBackground()
        
        self.loadData()
        
        //save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return templates.count
    }
    
    
    // Fill tableview with templates
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("templateCell", forIndexPath: indexPath)
        if !templates.isEmpty {
            cell.textLabel?.text = templates[indexPath.row].title
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! TemplateDetailViewController

        if segue.identifier == "createTemplateSegue" {
            print("new")
            destVC.titleForWindow = "Ny skabelon"
            destVC.createNewTemplate = true
        }
        if segue.identifier == "editTemplateSegue" {
            print("edit")
            destVC.titleForWindow = "Rediger skabelon"
            destVC.templateBeingEdited = templates[templateTableview.indexPathForSelectedRow!.row]
        }
    }
    
    func loadData() {
        let request = NSFetchRequest(entityName: "Template")
        
        do {
            let results = try managedContext.executeFetchRequest(request)
            self.templates = results as! [Template]
            
        } catch {
            print("error in loading \(error)")
        }
    }
    
    func save() {
        
        let income = NSEntityDescription.insertNewObjectForEntityForName("Template", inManagedObjectContext: managedContext) as! Template
        income.title = "Bankroll Mafia"
        
        do {
            try managedContext.save()
            print("Saved")
        } catch {}
        
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
