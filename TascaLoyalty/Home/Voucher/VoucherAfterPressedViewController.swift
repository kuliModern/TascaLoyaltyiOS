//
//  VoucherAfterPressedViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 02/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class VoucherAfterPressedViewController: UIViewController {

    @IBOutlet weak var howToUseButton: UIButton!
    @IBOutlet weak var descriptionButton: UIButton!
    
    @IBOutlet weak var hargaPoint: UILabel!
    @IBOutlet weak var namaResto: UILabel!
    @IBOutlet weak var durasiVoucher: UILabel!
    @IBOutlet weak var DescVoucher: UILabel!
    @IBOutlet weak var howToUse: UILabel!
    
    @IBOutlet weak var gambarVoucher: UIImageView!
    
    // variablenya
    
    var hargaPoints = ""
    var namaRestorannya = ""
    var durasinya = ""
    var deskripsiVoucher = ""
    var gambarVouchernya = UIImage()
    
    var idCoupon: String?
    var tokenUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // Button Desc
        descriptionButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        howToUse.isHidden = true
        
        // biar gaada tab barnya
        self.tabBarController?.tabBar.isHidden = true
        // buat bulet point
        hargaPoint.layer.masksToBounds = true
        hargaPoint.layer.cornerRadius = 45
        
        // Assign Label
        hargaPoint.text = hargaPoints
        namaResto.text = namaRestorannya
        durasiVoucher.text = durasinya
        DescVoucher.text = deskripsiVoucher
        // Image
        gambarVoucher.image = gambarVouchernya
        
        print(tokenUser)
        
        
    }
    
    @IBAction func descPressed(_ sender: UIButton) {
        descriptionButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        howToUseButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        howToUse.isHidden = true
        DescVoucher.isHidden = false
    }
    
    @IBAction func howToUse(_ sender: UIButton) {
        howToUseButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        descriptionButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        howToUse.isHidden = false
        DescVoucher.isHidden = true
        
        
        
    }
    
    @IBAction func getVoucher(_ sender: UIButton) {
        
        let urlString   = "\(url.linkFaris)/api/createvoucher"
        
        let parameters  = ["idCoupon": idCoupon!]
        
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
                                     "Authorization": "Bearer \(tokenUser!)"
        
        ]

        AF.request(urlString, method: .post, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
          switch response.result {
          case .success(let value):
           
            
            print("Validation Successful")
            print(response)
            let json = JSON(value)
            
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
