//
//  VoucherViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 26/01/21.
//

import UIKit
import Alamofire
import AlamofireImage


class VoucherViewController: UIViewController {

    
    
    @IBOutlet weak var testing1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        testing1.load(urlString: "https://ad2776ed921a.ngrok.io/storage/fotoprofil/1_profile.png")
        
            }
   

}
    
    extension UIImageView {
        func load(urlString : String) {
            guard let url = URL(string: urlString)else {
                return
            }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
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


