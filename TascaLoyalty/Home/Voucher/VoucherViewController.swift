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
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var filterbyBrandButton: UIButton!
    
    
    
    var tokenID: String?
    var testing1 = VoucherAfterPressedViewController()
    
    
    var id = [String]()
    var validUntil = [String]()
    var checkX: [Int] = []
    var hargaPoin = [String]()

    var test: Int?
    
    var namaRestoran = [String]()
    var filtered: [String] = []
    var filtering: [String] = []
    var filterBrands: String?
    
    var jenisVoucher = [String]()
    var filteredJenisVoucher: [String] = []

    var photos = [String]()
    
    var deskripsiVoucher = [String]()
    
    var userPointSebelumDipotong: Int?
    
   
     
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        
        
        self.myTable.delegate = self
        self.myTable.dataSource = self
 
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
     
        filterbyBrandButton.layer.masksToBounds = true
        filterbyBrandButton.layer.cornerRadius = 20
        
       
        print("\(tokenID!) dari Voucher")
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        parseJSON()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        // apus arraynya kalo user udah pindah screen
        namaRestoran.removeAll()
        validUntil.removeAll()
        deskripsiVoucher.removeAll()
        jenisVoucher.removeAll()
        hargaPoin.removeAll()
        photos.removeAll()
        filtering.removeAll()
        
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
           
            // Parsing user point
            let poinUser = json[ "User Points"].intValue
            self.userPointSebelumDipotong = poinUser
           
            
            // Nama Restoran
            for x in 0...count - 1{
                let nameRestoJson = json["coupons"][x]["restaurant_id"]["name"].stringValue
                self.namaRestoran.append("\(nameRestoJson)")
                self.filtering.append("\(nameRestoJson)")
                
               
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
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterByBrand"{
            if let destinationVC = segue.destination as? FilterByBrandViewController{
                destinationVC.brands = { newBrands in
                    print(newBrands)
                    self.filterBrands = newBrands
                    self.filterbyBrandButton.setTitle("Filter by \(newBrands)", for: .normal)
                  
                    
                    for x in 0...self.namaRestoran.count - 1{
                    if self.namaRestoran[x] == newBrands{
                            self.filtered.append(self.namaRestoran[x])
                        //buat nyari dia index ke berapa yang sesuai sama filter
                        self.checkX.append(x)
          
                    }
                        if newBrands == "Brand"{
                            self.filtered.append(self.namaRestoran[x])
                            
                            //kalo filter diilangin, append semuanya jadi kek normal
                            self.checkX.append(x)
                        }
                        
                    }
                  
                  // buat count berapa cellnya
                    self.filtering = self.filtered
                    
                    // Reload Data yang ada di cell
                    self.myTable.reloadData()
                }
               // diapus filteringnya biar kembali ke 0 buat di append sama nama restoran
                self.filtering.removeAll()
                // di append ke nama restoran
                self.filtering = self.namaRestoran
                // abis di append, tempnya diapus buat kalo user mencet berikutnya
                self.filtered.removeAll()
                // abis reload data buat array index-nya diapus buat usernya kalo mau mencet berikutnya
                self.checkX.removeAll()
                
                
            }
        }
    }
}
    
extension VoucherViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return filtering.count
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardVoucher", for: indexPath) as! CardVoucherTableViewCell
        
        // kalo arraynya si checkX itu kosong ( baru pertama ) itu kayak normal
        if checkX.isEmpty{
            
                cell.namaRestoran.text = namaRestoran[indexPath.row]
                cell.jenisVoucher.text = jenisVoucher[indexPath.row]
                cell.durasiVoucher.text = validUntil[indexPath.row]
                cell.hargaVoucher.text = hargaPoin[indexPath.row]
            
        }
        
        // kalo si user udah klik filternya, array si CheckX bakal keisi dan sesuai sama arraynya
        else{
           // print(checkX[indexPath.row])
            test = checkX[indexPath.row]
            cell.namaRestoran.text = namaRestoran[test!]
            cell.jenisVoucher.text = jenisVoucher[test!]
            cell.durasiVoucher.text = validUntil[test!]
            cell.hargaVoucher.text = hargaPoin[test!]
        }

        // Image
        
        AF.request(photos[indexPath.row]).responseImage { response in
            //debugPrint(response)
            if case .success(let image) = response.result{
                DispatchQueue.main.async {
                    //print(image)
                    cell.gambarRestoran.image = image
                    self.testing1.gambarVouchernya = image
                    
                    
                }
               
            }
            
        }
        
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        spinner.isHidden = false
        spinner.startAnimating()
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
            if self.checkX.isEmpty{
            vc.hargaPoints = self.hargaPoin[indexPath.row]
            vc.namaRestorannya = self.namaRestoran[indexPath.row]
            vc.durasinya = self.validUntil[indexPath.row]
            vc.deskripsiVoucher = self.deskripsiVoucher[indexPath.row]
            vc.jenisVoucher = self.jenisVoucher[indexPath.row]
            }
            else{
                self.test = self.checkX[indexPath.row]
                vc.hargaPoints = self.hargaPoin[self.test!]
                vc.namaRestorannya = self.namaRestoran[self.test!]
                vc.durasinya = self.validUntil[self.test!]
                vc.deskripsiVoucher = self.deskripsiVoucher[self.test!]
                vc.jenisVoucher = self.jenisVoucher[self.test!]
            }
            
            vc.idCoupon = self.id[indexPath.row]
            // user point
            vc.userPointSebelumDipotong = self.userPointSebelumDipotong
            
            // User TOken
            
            vc.tokenUser = self.tokenID
            
        self.navigationController?.pushViewController(vc, animated: true)
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
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


