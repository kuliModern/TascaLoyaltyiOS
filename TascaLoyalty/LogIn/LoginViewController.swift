//
//  LoginViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 20/01/21.
//

import UIKit
import GoogleSignIn
import Alamofire
import SwiftyJSON


class LoginViewController: UIViewController, GIDSignInDelegate {

    var tokenid: String = ""
    
    override func viewDidLoad() {
        // spinner
        
        spinner.isHidden = true
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        // Do any additional setup after loading the view.
        // Rounded Corner
        emailButton.layer.cornerRadius = 20
        googlePressed.layer.cornerRadius = 20
        appleButton.layer.cornerRadius = 20
        // Border/Outline Color
        emailButton.layer.borderWidth = 3
        googlePressed.layer.borderWidth = 3
        appleButton.layer.borderWidth = 3
        // Add Color to the border
        emailButton.layer.borderColor = #colorLiteral(red: 0.9999516606, green: 0.8314109445, blue: 0.0001840102777, alpha: 1)
        googlePressed.layer.borderColor = #colorLiteral(red: 0.9999516606, green: 0.8314109445, blue: 0.0001840102777, alpha: 1)
        appleButton.layer.borderColor = #colorLiteral(red: 0.9999516606, green: 0.8314109445, blue: 0.0001840102777, alpha: 1)
        
    }
   

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var googlePressed: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBAction func daftarApple(_ sender: UIButton) {
        
        
    }
    @IBAction func daftarGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        
    }

    @IBAction func daftarEmail(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "RegisterToEmail", sender: self)
    }
    
    
    @IBAction func testing1(_ sender: Any) {
        self.performSegue(withIdentifier: "DatabaseToHome", sender: self)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
              print("The user has not signed in before or they have since signed out.")
            } else {
              print("\(error.localizedDescription)")
            }
            return
          }
          // Perform any operations on signed in user here.
          let userId = user.userID                  // For client-side use only!
          let idToken = user.authentication.idToken // Safe to send to the server
          let fullName = user.profile.name
          let givenName = user.profile.givenName
          let familyName = user.profile.familyName
          let email = user.profile.email
        
        spinner.isHidden = false
        spinner.startAnimating()
      
        // Prepare URL
        let parameters: [String: Any] = [
            "idToken" : idToken
        ]
       
        AF.request("\(url.linkFaris)/api/gsignin", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response -> Void in
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                
                switch response.result{
                case .success(let value):
                    
                    let json = JSON(value)
                    let token = json["token"].stringValue
                    print(response)
                    debugPrint(token)
                    
                    self.tokenid = token
                   
                    
                    self.performSegue(withIdentifier: "LoginToDatabase", sender: self)
                    
                case .failure(let error):
                    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "LoginToDatabase"{
            let destinationVC = segue.destination as! DatabaseViewController
            destinationVC.tokenID = tokenid
           
            
        }
    }
}
