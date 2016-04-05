//
//  ExpensesController.swift
//  Budgetto
//
//  Created by Jens Herlevsen on 04/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class ExpensesController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBAction func returnedFromDetailView (segue : UIStoryboardSegue) {
        print("Bla")
    }
    
    @IBOutlet weak var expensesTableview: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expensesTableview.delegate = self
        expensesTableview.dataSource = self
        
        self.view.setDefaultBackground()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // Number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)!"
        
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "createExpenseSegue" {
            print("Ny Udgift")
        }
        if segue.identifier == "editExpenseSegue" {
            print("Rediger Udgift")
        }
        
    }

    
    
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
