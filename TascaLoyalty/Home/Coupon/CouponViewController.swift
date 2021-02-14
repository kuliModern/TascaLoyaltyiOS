//
//  CouponViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 29/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON


class CouponViewController: UIViewController{
    
   
    var tokenID: String?
  
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var images = [String]()
    
    var namaRestoran: [String] = []
    
    var durasi = [String]()
    
    var namaPromo = [String]()
    
    var descPromo = [String]()
    
    var restoStatus = [String]()
    
    
    var dispatch = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(tokenID) dari coupon")
       
        
    }
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // sebelum datanya keluar, user interactionnya di freeze biar gak nil
        spinner.isHidden = false
        spinner.startAnimating()
        self.view.isUserInteractionEnabled = false
        print("sebelum parsing")
        
        parseJSON()
        
        // Ini dia mastiin si ParseJSONnya itu ke run dulu baru yang .notify ini, diliat di func parseJSON itu ada dispatch.enter, itu buat mastiin yang dari enter - ending ke run dulu, baru bisa lanjut enable
        dispatch.notify(queue: .main) {
            self.view.isUserInteractionEnabled = true
            print("sesudah parsing")
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
       
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        namaPromo.removeAll()
        durasi.removeAll()
        namaRestoran.removeAll()
        images.removeAll()
        
    }
    
    func parseJSON(){
        dispatch.enter()
            let urlString   = "\(url.linkFaris)/api/getpromotion"
    
            let headers: HTTPHeaders = [ "Accept": "application/json",
                                 "Authorization": "Bearer \(tokenID!)"
    
    ]

            AF.request(urlString, method: .get, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
       
        
                    print("Validation Successful")
                    print(response)
                    let json = JSON(value)
                    var counting = json["promotions"].count
                    
                    
                    for x in 0...counting - 1{
                        var namaVoucher = json["promotions"][x]["name"].stringValue
                        self.namaPromo.append("\(namaVoucher)")
                        
                        var namaResto = json["promotions"][x]["restaurant_id"]["name"].stringValue
                        self.namaRestoran.append("\(namaResto)")
                        
                        var durasiPromo = json["promotions"][x]["expiry_date"].stringValue
                        self.durasi.append("\(durasiPromo)")
                        
                        var fotoPromo = json["promotions"][x]["path_photo"].stringValue
                        self.images.append("\(fotoPromo)")
                        
                        var descPromo = json["promotions"][x]["description"].stringValue
                        self.descPromo.append("\(descPromo)")
                        
                        var restoStatus = json["promotions"][x]["status"].stringValue
                        self.restoStatus.append("\(restoStatus)")
                    }
                    
                   
                    self.tableView.reloadData()
                    self.dispatch.leave()
                    
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
 
extension CouponViewController: UITableViewDelegate, UITableViewDataSource{
   
    // JUmlah Cellnya ada berapa
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namaPromo.count
    }
    
    // Isi cellnya itu 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardTableViewCell
        
        
            cell.jenisDiskon.text = self.namaPromo[indexPath.row]
            cell.durasiDiskon.text = self.durasi[indexPath.row]
            cell.namaRestoran.text = self.namaRestoran[indexPath.row]
        
        // Image Cellnya
        
            AF.request(self.images[indexPath.row]).responseImage { response in
            //debugPrint(response)
            if case .success(let image) = response.result{
                DispatchQueue.main.async {
                    //print(image)
                    cell.myImageVIew.image = image
                }
               
            }
            
        }
        
        
        // Animasi Cellnya
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
         return cell
        
    }
    // View Cell kalo dipencet
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let vc = storyboard?.instantiateViewController(identifier: "AfterPressedViewController") as! AfterPressedViewController
       
      
        // Pass value text
        vc.namaRestorannya = namaRestoran[indexPath.row]
        vc.jenisDiskonRestoran = namaPromo[indexPath.row]
        vc.durasiDiskonRestoran = durasi[indexPath.row]
        vc.descPromonya = descPromo[indexPath.row]
        vc.restoStatus = restoStatus[indexPath.row]
        // Pass Image
        
        AF.request(images[indexPath.row]).responseImage { response in
            //debugPrint(response)
            if case .success(let image) = response.result{
                DispatchQueue.main.async {
                    print(image)
                    vc.MyImage.image = image

                }
                
            }
        }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
       
       
    }
  
}

