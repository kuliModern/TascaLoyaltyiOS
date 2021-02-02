//
//  VoucherViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 26/01/21.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class VoucherViewController: UIViewController {
    var tokenID: String?
    
    var testing1 = VoucherAfterPressedViewController()
    @IBOutlet weak var myTable: UITableView!
    
    var gambarVoucher = [ UIImage(named: "maumere"),
                          UIImage(named: "menu"),
                          UIImage(named: "freemilk")
    ]
    var id = [String]()
    var validUntil = [String]()

    var hargaPoin = [String]()

    var namaRestoran = [String]()
    
    var jenisVoucher = [String]()

    var photos = [String]()
    
    var deskripsiVoucher = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTable.delegate = self
        self.myTable.dataSource = self
        
       
        print("\(tokenID!) dari Voucher")
        parseJSON()
    }
    
    
    
    
    
        // Nembak ke Faris
    func parseJSON(){
        let urlString   = "\(url.linkFaris)/api/getcoupon"
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
                                     "Authorization": "Bearer \(tokenID!)"
        
        ]

        AF.request(urlString, method: .get, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
          switch response.result {
          case .success(let value):
           
            
            print("Validation Successful")
            print(response)
            let json = JSON(value)
            var count = json["coupons"].count
           
          
            
            // Nama Restoran
            for x in 0...count - 1{
                let nameRestoJson = json["coupons"][x]["restaurant_id"]["name"].stringValue
                self.namaRestoran.append("\(nameRestoJson)")
               
            }
            
            // Count Cell
            for x in 0...count - 1{
                let idJson = json["coupons"][x]["id"].intValue
                self.id.append("\(idJson)")
               
            }
            // Price Point
            for x in 0...count - 1{
                let priceJson = json["coupons"][x]["price"].intValue
                self.hargaPoin.append("\(priceJson) Point")
               
            }
        
            // Iterate Durasinya
            for x in 0...count - 1{
            let StringBaru = json["coupons"][x]["expiry_date"].string
               
                self.validUntil.append("\(StringBaru!)")
                
                
            }
            // Jenis Voucher
            for x in 0...count - 1{
                let jenisDiskon = json["coupons"][x]["name"].stringValue
                
                self.jenisVoucher.append("\(jenisDiskon)")
            }
            // Deskripsi Voucher
            
            for x in 0...count - 1{
                let descVoucher = json["coupons"][x]["description"].stringValue
                self.deskripsiVoucher.append("\(descVoucher)")
            }
            
            // Foto Voucher
            
            for x in 0...count - 1{
                let JenisFoto = json["coupons"][x]["path_photo"].stringValue
                self.photos.append("\(JenisFoto)")
            }
            
            self.myTable.reloadData()
            
          case let .failure(error):
            
            print(error)
           
          }
           
        }
    }
        
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }

    
}
    
extension VoucherViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return id.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardVoucher", for: indexPath) as! CardVoucherTableViewCell
        
        //cell.gambarRestoran.image = gambarVoucher[indexPath.row]
        cell.durasiVoucher.text = validUntil[indexPath.row]
        cell.namaRestoran.text = namaRestoran[indexPath.row]
        cell.hargaVoucher.text = hargaPoin[indexPath.row]
        cell.jenisVoucher.text = jenisVoucher[indexPath.row]
        
        
        
      
        // Image
        
        AF.request(photos[indexPath.row]).responseImage { response in
            //debugPrint(response)
            if case .success(let image) = response.result{
                DispatchQueue.main.async {
                    print(image)
                    cell.gambarRestoran.image = image
                    self.testing1.gambarVouchernya = image
                    
                    
                }
               
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let vc = storyboard?.instantiateViewController(identifier: "VoucherAfterPressed") as! VoucherAfterPressedViewController
        
        // Parse Image ke VC berikutnya
        AF.request(photos[indexPath.row]).responseImage { response in
            //debugPrint(response)
            if case .success(let image) = response.result{
                DispatchQueue.main.async {
                    print(image)
                    vc.gambarVoucher.image = image

                }
                
            }
            vc.hargaPoints = self.hargaPoin[indexPath.row]
            vc.namaRestorannya = self.namaRestoran[indexPath.row]
            vc.durasinya = self.validUntil[indexPath.row]
            vc.deskripsiVoucher = self.deskripsiVoucher[indexPath.row]
            vc.idCoupon = self.id[indexPath.row]
            
            // User TOken
            
            vc.tokenUser = self.tokenID
            
        self.navigationController?.pushViewController(vc, animated: true)
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
