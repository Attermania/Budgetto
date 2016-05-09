//
//  BudgettoNavigationController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 09/05/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class BudgettoNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Color of icons in navigation bar
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    
}
