//
//  ActivationNumberEmailViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 24/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ActivationNumberEmailViewController: UIViewController, UITextFieldDelegate {

        
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var middleView: UIView!
   
    @IBOutlet weak var nomorAktivasi: UITextField!
    @IBOutlet weak var lanjutButton: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailText: UILabel!
    
    
    var emailUserID: String? = ""
    var tokenUser: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // spinner
        spinner.isHidden = true
        // Round Corner
        lanjutButton.layer.cornerRadius = 35
        viewNumber.layer.cornerRadius = 40
        
        // Text Field Delegate
        nomorAktivasi.delegate = self
        
        middleView.layer.cornerRadius = 50
        // biar yang orund cuman yang atas
        middleView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        
        ]
        
        // Do any additional setup after loading the view.
 }
    override func viewDidAppear(_ animated: Bool) {
       
        emailText.text = "Kami telah mengirimkan 4 digit nomor aktivasi ke alamat email \(emailUserID!)"
    }
    
    let MAX_LENGTH_PHONENUMBER = 4
    let ACCEPTABLE_NUMBERS     = "0123456789"
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                        
                let newLength: Int = textField.text!.count + string.count - range.length
                let numberOnly = NSCharacterSet.init(charactersIn: ACCEPTABLE_NUMBERS).inverted
                let strValid = string.rangeOfCharacter(from: numberOnly) == nil
                return (strValid && (newLength <= MAX_LENGTH_PHONENUMBER))
        }
        
    
    
    @IBAction func lanjutPressed(_ sender: UIButton)  {
        //spinner
        spinner.startAnimating()
        spinner.isHidden = false
        
        
        var digit = nomorAktivasi.text!
        
        print("-----")
        print(emailUserID!)
        print(digit)
        
        
        let urlString   = "\(url.linkFaris)/api/codeverification"
        
        let parameters  = ["code": digit,
                           "email": emailUserID!
        ]
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
        
        ]

        AF.request(urlString, method: .post, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
            
          switch response.result {
          case .success(let value):

            print("Validation Successful")
            print(response)
            let json = JSON(value)
            print(json)
            print("------")
            
            // Parse dari JSON buat ambil Messagenya
            self.tokenUser = json["token"].string ?? ""
            debugPrint(self.tokenUser)
            
            let message = json["message"].string
            debugPrint(message!)
            
            if message == "Success"{
                
                self.performSegue(withIdentifier: "ActivationNumberToDatabase", sender: self)
            }
            
            else if message == "Wrong code"{
                let alert = UIAlertController(title: "\(message!)", message: "Kode yang anda masukan salah", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                self.spinner.isHidden = true
            }

          case let .failure(error):
            print(error)

          }
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ActivationNumberToDatabase"{
            let destinationVC = segue.destination as! DatabaseViewController
            destinationVC.tokenID = tokenUser
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
