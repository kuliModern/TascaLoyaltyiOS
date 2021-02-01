//
//  LogInEmailViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 25/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class LogInEmailViewController: UIViewController {
    @IBOutlet weak var botVIew: UIView!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var tokenUser: String = ""
   
    override func viewDidLoad() {
        // Spinner
        
        spinner.isHidden = true
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        botVIew.layer.cornerRadius = 35
        botVIew.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        
        ]
    }
    
    
    @IBAction func lanjutPressed(_ sender: UIButton) {
        
        //Spinner
        spinner.startAnimating()
        spinner.isHidden = false
       
        
        var email = emailText.text!
        var password = passwordText.text!
        
        let urlString   = "\(url.linkFaris)/api/login"
        
        let parameters  = ["email": email,
                           "password": password
        ]
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
        
        ]

        AF.request(urlString, method: .post, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
            
            // Spinner
          
            self.spinner.isHidden = true
            
          switch response.result {
      
          case .success(let value):

            print("Validation Successful")
            print(response)
            let json = JSON(value)
            print(json)
            print("------")
            
            // Parse dari JSON buat ambil Messagenya
            let parsing = json["token"].string ?? ""
            debugPrint(parsing)
            self.tokenUser = parsing
            print(self.tokenUser)
            
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
            
          case let .failure(error):
            print(error)

          }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginToHome"{
            let custMainVC = segue.destination as! UITabBarController
            let res = custMainVC.viewControllers!.first as! HomeViewController
            res.tokenID = self.tokenUser
        }
        
        
    }
}

