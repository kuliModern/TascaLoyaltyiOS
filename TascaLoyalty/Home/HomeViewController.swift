//
//  HomeViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 26/01/21.
//

import UIKit

class HomeViewController: UIViewController {

    var tokenID: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
       print(tokenID)
        // Passing ke Coupon
        let navController = self.tabBarController!.viewControllers![2] as! UINavigationController
        let cp = navController.topViewController as! CouponViewController
        cp.tokenID = self.tokenID
        
        
        // Passing ke Voucher
        let voucher = self.tabBarController!.viewControllers![1] as! UINavigationController
        let vc = voucher.topViewController as! VoucherViewController
        vc.tokenID = self.tokenID
       
    }
    

    @IBAction func voucherPressed(_ sender: UIButton) {
      
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



