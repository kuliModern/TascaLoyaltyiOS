//
//  OutletViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 09/02/21.
//

import UIKit

class OutletViewController: UIViewController {

    
    @IBOutlet weak var locationResto: UILabel!
    @IBOutlet weak var phoneResto: UILabel!
    
    var resto: String?
    var phone: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationResto.text = resto
        phoneResto.text = phone
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
