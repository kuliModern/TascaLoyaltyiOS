//
//  ActivationNumberEmailViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 24/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ActivationNumberEmailViewController: UIViewController {

    
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var middleView: UIView!
   
    @IBOutlet weak var nomorAktivasi: UITextField!
    @IBOutlet weak var lanjutButton: UIButton!
    
    
    var emailUserID: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round Corner
        lanjutButton.layer.cornerRadius = 35
        viewNumber.layer.cornerRadius = 40
        
        
        middleView.layer.cornerRadius = 50
        // biar yang orund cuman yang atas
        middleView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        
        ]
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func lanjutPressed(_ sender: UIButton)  {
        
        var digit = nomorAktivasi.text!
        
        print("-----")
        print(emailUserID)
        
        
        let urlString   = "https://8d439431640a.ngrok.io/api/codeverification"
        
        let parameters  = ["code": digit,
                           "email": emailUserID
        ]
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
        
        ]

        AF.request(urlString, method: .post, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
            
          switch response.result {
          case .success:

            print("Validation Successful")
            print(response)
            self.performSegue(withIdentifier: "ActivationNumberToDatabase", sender: self)
            
          case let .failure(error):
            print(error)
           
            
           
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

}
