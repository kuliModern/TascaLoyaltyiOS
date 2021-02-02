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
    
    var selectedIndex = 0
    var tokenID: String?
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var testLabel: UILabel!
    let images = [UIImage(named: "freemilk"),
                  UIImage(named: "menu"),
                  UIImage(named: "maumere")
    ]
    let name = ["freemilk", "menu", "maumere"]
    
    let namaRestoran = ["Maumere",
                        "Maumere",
                        "Freemilk"
    ]
    
    let jenisDiskon = ["GOJEK",
                       "Grab",
                       "Tokopedia"
    ]
    var durasi = [String]()
    
    var testArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        
        print(tokenID)
        
        let urlString   = "\(url.linkFaris)//"
        
        let headers: HTTPHeaders = [ "Accept": "application/json",
                                     "Authorization": "Bearer \(tokenID)"
        
        ]

        AF.request(urlString, method: .get, encoding:  URLEncoding.queryString, headers: headers).responseJSON { response in
          switch response.result {
          case .success(let value):
           
            
            print("Validation Successful")
            print(response)
            let json = JSON(value)
            let count = json["coupons"].count
            
            print(count)
            // Iterate Durasinya
            for _ in 0...count{
            let StringBaru = json["coupons"][count - 1]["expiry_date"].string

                self.durasi.append("\(StringBaru!)")
            }
            
            
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
        return images.count
    }
    
    // Isi cellnya itu 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardTableViewCell
        
        // diganti dari yang CardTableView
        cell.myImageVIew.image = UIImage(named: name[indexPath.row])
       // cell.durasiDiskon.text = durasi[indexPath.row]
        cell.jenisDiskon.text = jenisDiskon[indexPath.row]
       cell.namaRestoran.text = namaRestoran[indexPath.row]
        
        
        
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
        selectedIndex = indexPath.row
        let vc = storyboard?.instantiateViewController(identifier: "AfterPressedViewController") as! AfterPressedViewController
        // PAss value Gambar Restoran
        vc.gambarRestoran = UIImage(named: name[indexPath.row])!
        // Pass value text
        vc.namaRestorannya = namaRestoran[indexPath.row]
        vc.jenisDiskonRestoran = jenisDiskon[indexPath.row]
        vc.durasiDiskonRestoran = durasi[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
       
       
    }
   
}

