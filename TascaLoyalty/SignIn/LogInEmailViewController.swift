//
//  LogInEmailViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 25/01/21.
//

import UIKit

class LogInEmailViewController: UIViewController {
    @IBOutlet weak var botVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        botVIew.layer.cornerRadius = 35
        botVIew.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        
        ]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
