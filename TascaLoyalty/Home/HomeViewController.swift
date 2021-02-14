//
//  HomeViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 26/01/21.
//

import UIKit

class HomeViewController: UIViewController {

    var tokenID: String?
    
   
    
    @IBOutlet weak var Logout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        var TokenUser = UserDefaults.standard.string(forKey: "isUserLogin")
        tokenID = TokenUser
        
        print("\(tokenID) token user di Home ")
        
        // Passing ke Coupon
        
        let navController = self.tabBarController?.viewControllers![3] as! UINavigationController
        let cp = navController.topViewController as! CouponViewController
        cp.tokenID = self.tokenID
        
       
        // Passing ke Voucher
        let voucher = self.tabBarController!.viewControllers![1] as! UINavigationController
        let vc = voucher.topViewController as! VoucherViewController
        vc.tokenID = self.tokenID
        
    }
    
    
    @IBAction func voucherPressed(_ sender: UIButton) {
      
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "isUserLogin")
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let StartupVC = story.instantiateViewController(withIdentifier: "StartupVC") as! ViewController
        UIApplication.shared.windows.first?.rootViewController = StartupVC
        
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
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



