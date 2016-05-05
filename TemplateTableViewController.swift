//
//  TemplateTableViewController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 05/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class TemplateTableViewController: UITableViewController {
    
    @IBOutlet var templateTableview: UITableView!
    
    let dao = DAO.instance
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
    }
    
    func loadData() {
        self.templates = dao.getAllTemplates()
    }
    
}
