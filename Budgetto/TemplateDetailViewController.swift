//
//  TemplateDetailViewController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 05/04/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class TemplateDetailViewController: UIViewController {
    
    let dao = DAO.instance

    var createNewTemplate = false
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save() {
        let template = dao.createTemplate()
        template.title = templateNameTextfield.text
        
        dao.save()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        save()
    }


}
