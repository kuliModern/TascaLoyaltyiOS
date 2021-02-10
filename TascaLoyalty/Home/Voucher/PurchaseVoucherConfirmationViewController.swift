//
//  PurchaseVoucherConfirmationViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 03/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SCLAlertView


class PurchaseVoucherConfirmationViewController: UIViewController {

    @IBOutlet weak var pointAbisDipotong: UILabel!
    @IBOutlet weak var hargaVoucher: UILabel!
    
    @IBOutlet weak var jenisVoucher: UILabel!
    
    @IBOutlet weak var durasiVoucher: UILabel!
    
    var Harganya: String?
    var Durasinya: String?
    var JenisVouchernya: String?
    var sisaPointnya: Int?
     
    var idCodeVoucher: String?
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var idCoupon: String?
    var tokenUser: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loading
        loading.isHidden = true
        
        // user point
        pointAbisDipotong.text = String(Int(sisaPointnya!))
        
        hargaVoucher.text = Harganya
        durasiVoucher.text = "Valid Until : \(Durasinya!)"
        jenisVoucher.text = "Voucher yang akan dibeli adalah     \(JenisVouchernya!)"
       
        
        // UI Point Usernya
        pointAbisDipotong.layer.masksToBounds = true
        pointAbisDipotong.layer.cornerRadius = 20
        
        // UI harga Voucher
        hargaVoucher.layer.masksToBounds = true
        hargaVoucher.layer.cornerRadius = 40
        
        // UI Jenis Voucher
        jenisVoucher.layer.cornerRadius = 20
        jenisVoucher.layer.borderWidth = 3
        jenisVoucher.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getVoucherPressed(_ sender: UIButton) {
        
        loading.startAnimating()
        loading.isHidden = false
        
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
            
            // iD Vouchernya
            var IdVoucher = json["voucher"]["code"].stringValue
            self.idCodeVoucher = IdVoucher
            
            // Nanti Lempar ke tab User si ID-Vouchernya
            
            
            //Ngambil sisa point ( Point asli - Point harga Voucher )
            let pointsAbisDipotong = json["points"].intValue
            self.sisaPointnya = pointsAbisDipotong

            print(self.idCodeVoucher)
            
            // Ngecheck, kalo kosong dia error, kalo engga lanjut
            if self.idCodeVoucher != nil{
                self.performSegue(withIdentifier: "idVoucher", sender: self)
            }else{
                SCLAlertView().showError("Pembelian Voucher Gagal", subTitle: "Pembelian Voucher \(self.JenisVouchernya!) gagal, silahkan coba lagi")
                
            }
            self.loading.isHidden = true
           
            
         case let .failure(error):
            
            print(error)
            SCLAlertView().showError("Pembelian Voucher Gagal", subTitle: "Pembelian Voucher \(self.JenisVouchernya) gagal, silahkan coba lagi, \(error)")
            self.loading.isHidden = true
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idVoucher"{
            let vc = segue.destination as! VoucherReceiptViewController
            
                vc.VoucherID = idCodeVoucher
                vc.JenisVouchernya = JenisVouchernya
                vc.sisapointnya = sisaPointnya!
            
          
          
        }
    }
}
