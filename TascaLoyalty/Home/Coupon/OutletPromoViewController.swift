//
//  OutletPromoViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 10/02/21.
//

import UIKit

class OutletPromoViewController: UIViewController {

    @IBOutlet weak var restoInfo: UILabel!
    @IBOutlet weak var noRestoInfo: UILabel!
    
    var restoText: String?
    var restoTelp: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        restoInfo.text = restoText
        noRestoInfo.text = restoTelp
        
        // Do any additional setup after loading the view.
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
