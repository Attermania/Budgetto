//
//  BudgettoTabBarController.swift
//  Budgetto
//
//  Created by Thomas Attermann on 09/05/2016.
//  Copyright © 2016 SJT. All rights reserved.
//

import UIKit

class BudgettoTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor.whiteColor()

        for item in self.tabBar.items! {
            item.image = item.selectedImage?.imageWithColor(UIColor.whiteColor()).imageWithRenderingMode(.AlwaysOriginal)
            let attributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
            item.setTitleTextAttributes(attributes, forState: .Normal)
        }
    }


}
