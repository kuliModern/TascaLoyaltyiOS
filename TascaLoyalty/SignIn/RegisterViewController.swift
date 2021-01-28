//
//  RegisterViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 20/01/21.
//

import UIKit
import GoogleSignIn
import Alamofire
import SwiftyJSON


class RegisterViewController: UIViewController, GIDSignInDelegate {
  
    

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    
    var tokenid: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //Spinner is hidden
        
        spinner.isHidden = true
        // Google SignIN
        GIDSignIn.sharedInstance()?.delegate = self

        // Do any additional setup after loading the view.
        emailButton.layer.cornerRadius = 20
        googleButton.layer.cornerRadius = 20
        appleButton.layer.cornerRadius = 20
        // Border/Outline Color
        emailButton.layer.borderWidth = 3
        googleButton.layer.borderWidth = 3
        appleButton.layer.borderWidth = 3
        // Add Color to the border
        emailButton.layer.borderColor = #colorLiteral(red: 0.9999516606, green: 0.8314109445, blue: 0.0001840102777, alpha: 1)
        googleButton.layer.borderColor = #colorLiteral(red: 0.9999516606, green: 0.8314109445, blue: 0.0001840102777, alpha: 1)
        appleButton.layer.borderColor = #colorLiteral(red: 0.9999516606, green: 0.8314109445, blue: 0.0001840102777, alpha: 1)
        
        
        
    }
   
    @IBAction func emailPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "LoginToLoginEmail", sender: self)
    }
    
    @IBAction func googlePressed(_ sender: UIButton) {
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
       
        
    }
    
    
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            spinner.isHidden = false
            spinner.startAnimating()
            
            
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
                    print(self.tokenid)
                    
                case .failure(let error):
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
}
