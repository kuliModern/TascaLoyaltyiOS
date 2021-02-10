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
  
    @IBOutlet weak var tableView: UITableView!
    
    
    var images = [String]()
    
    var namaRestoran: [String] = []
    
    var durasi = [String]()
    
    var namaPromo = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\(tokenID) dari coupon")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        parseJSON()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        namaPromo.removeAll()
        durasi.removeAll()
        namaRestoran.removeAll()
        images.removeAll()
        
    }
    
    func parseJSON(){
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
                    }
                    
                   
                    self.tableView.reloadData()
                    
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
        
    
        cell.jenisDiskon.text = namaPromo[indexPath.row]
        cell.durasiDiskon.text = durasi[indexPath.row]
        cell.namaRestoran.text = namaRestoran[indexPath.row]
        
        // Image Cellnya
        
        AF.request(images[indexPath.row]).responseImage { response in
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

