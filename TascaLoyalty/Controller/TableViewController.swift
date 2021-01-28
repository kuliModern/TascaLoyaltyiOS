//
//  TableViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 28/01/21.
//

import UIKit
import SwipeableTabBarController

class TableViewController: SwipeableTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        // Swipe between VC
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        isCyclingEnabled = true
     
    }
}
    
    
