//
//  RegisterEmailViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 20/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterEmailViewController: UIViewController {
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var lanjutButton: UIButton!
    
    @IBOutlet weak var userEmail: UITextField!
    var emailUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // Do any additional setup after loading the view.
       // buat round corner
     
        lanjutButton.layer.cornerRadius = 35
        middleView.layer.cornerRadius = 50
        middleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       }
    
    @IBAction func lanjutPressed(_ sender: UIButton) {
        
        
        var emailUser = userEmail.text!
        print(emailUser)
        
        let urlString   = "https://8d439431640a.ngrok.io/api/requestcode"
        
        let parameters  = ["email": emailUser
        ]
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
        
        ]

        AF.request(urlString, method: .post, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
          switch response.result {
          case .success:

            print("Validation Successful")
            print(response)
            print("_-------")
            print(emailUser)
            self.performSegue(withIdentifier: "RegisterEmailtoActivationNumber", sender: self)
            
          case let .failure(error):
            print(error)
           
          }
            
        }
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterEmailtoActivationNumber"{
            let destinationVC = segue.destination as! ActivationNumberEmailViewController
            destinationVC.emailUserID = userEmail.text!
            
        }
        
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


