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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userEmail: UITextField!
    var emailUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
       // Do any additional setup after loading the view.
       // buat round corner
     
        lanjutButton.layer.cornerRadius = 35
        middleView.layer.cornerRadius = 50
        middleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       }
    
    @IBAction func lanjutPressed(_ sender: UIButton) {
        // Spinner
        self.spinner.startAnimating()
        self.spinner.isHidden = false
        
        let emailUser = userEmail.text!
        print(emailUser)
        
        let urlString   = "\(url.linkFaris)/api/requestcode"
        
        let parameters  = ["email": emailUser
        ]
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
        
        ]

        AF.request(urlString, method: .post, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).responseJSON { [self] response in
          switch response.result {
          case .success(let value):
      
            print("Validation Successful")
            print(response)
            let json = JSON(value)
            print(json)
            print("-------")
            
            let message = json["message"].string
            debugPrint(message!)
            
             if message == "Code telah di-email"{
                 
             self.performSegue(withIdentifier: "RegisterEmailtoActivationNumber", sender: self)
                // spinner
                
                self.spinner.isHidden = true
             }
             else if message == "Email already registered and verified"{
               
                
                let alert = UIAlertController(title: "\(message!)", message: "Anda sudah daftar, silahkan Log In ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
                //spinner
                
                self.spinner.isHidden = true
             }
             
             else if ((message?.contains("Coba lagi dalam menit")) != nil){
                let alert = UIAlertController(title: "\(message!)", message: "Anda sudah memasukan Email yang sama, Silahkan \(message!)", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             
                self.present(alert, animated: true)
                spinner.stopAnimating()
                spinner.isHidden = true
            }
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


