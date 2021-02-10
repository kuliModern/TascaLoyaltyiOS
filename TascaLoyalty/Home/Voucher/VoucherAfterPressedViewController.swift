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
    
    // Ui Buttonnya
    @IBOutlet weak var howToUseButton: UIButton!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var outletButton: UIButton!
    
    
    
   
    
    
    
    @IBOutlet weak var hargaPoint: UILabel!
    @IBOutlet weak var namaResto: UILabel!
    @IBOutlet weak var durasiVoucher: UILabel!
    @IBOutlet weak var DescVoucher: UILabel!
    @IBOutlet weak var howToUse: UILabel!
    @IBOutlet weak var jenisVouchernya: UILabel!
    
    @IBOutlet weak var gambarVoucher: UIImageView!
    
   
    
    @IBOutlet weak var myView: UITableView!
    
    
    // variablenya
    
    var hargaPoints = ""
    var namaRestorannya = ""
    var durasinya = ""
    var deskripsiVoucher = ""
    var jenisVoucher = ""
    
    var userPointSebelumDipotong: Int?
    
    var gambarVouchernya = UIImage()
    
    var idCoupon: String?
    var tokenUser: String?
    
    // Array buat outlet dari faris
    var locationResto = [String]()
    var phoneResto = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hidden table viewnya buat outlet doang
        myView.layer.isHidden = true
        
       
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
        jenisVouchernya.text = jenisVoucher
        // Image
        gambarVoucher.image = gambarVouchernya
        
        print(tokenUser!)
        
        
    }
    
    @IBAction func descPressed(_ sender: UIButton) {
        // Hide Viewnya
        myView.layer.isHidden = true
        // UI
        descriptionButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        howToUseButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        outletButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        howToUse.isHidden = true
        DescVoucher.isHidden = false
        
        
        locationResto.removeAll()
      
    }
    
    @IBAction func howToUse(_ sender: UIButton) {
        // Hide Viewnya
        myView.layer.isHidden = true
        // UI
        howToUseButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        descriptionButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        outletButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        howToUse.isHidden = false
        DescVoucher.isHidden = true
        
        
        locationResto.removeAll()

    }
    
    
    @IBAction func outletPressed(_ sender: UIButton) {
        myView.layer.isHidden = false
        outletButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        howToUseButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        descriptionButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        // Tombol yang lain ilang
        howToUse.isHidden = true
        DescVoucher.isHidden = true
      
        // Parsing faris
        
        let urlString   = "\(url.linkFaris)/api/getbranch?restaurant_name=\(namaRestorannya)"
       
        AF.request(urlString, method: .get, encoding:  URLEncoding.queryString).responseJSON { response in
          switch response.result {
          case .success(let value):
           
            
            print("Validation Successful")
            print(response)
            let json = JSON(value)
            
            let counting = json["branch"].count
            
            for x in 0...counting-1{
                let restoLocation = json["branch"][x]["location"].stringValue
                self.locationResto.append("\(restoLocation)")
                
                let restoPhonenum = json["branch"][x]["phone_number"].stringValue
                self.phoneResto.append("\(restoPhonenum)")
                
                
            }
            print(counting)
            print(self.locationResto)
            print(self.phoneResto)
            
            
            
          case let .failure(error):
            
            print(error)
           
          }
            self.myView.reloadData()
        }
}
    

    
    @IBAction func getVoucher(_ sender: UIButton) {
        self.performSegue(withIdentifier: "VoucherConfirmation", sender: self)

          }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VoucherConfirmation"{
            let destinationVC = segue.destination as! PurchaseVoucherConfirmationViewController
            destinationVC.idCoupon = idCoupon
            destinationVC.tokenUser = tokenUser
            
            destinationVC.Harganya = hargaPoints
            destinationVC.Durasinya = durasinya
            destinationVC.JenisVouchernya = jenisVoucher
            destinationVC.sisaPointnya = userPointSebelumDipotong
            print(userPointSebelumDipotong)
    
        }
    }
        }
        
    
extension VoucherAfterPressedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationResto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let outletCell = tableView.dequeueReusableCell(withIdentifier: "outletCell", for: indexPath) as! OutletTableViewCell
        
        outletCell.labelLocationResto.text = locationResto[indexPath.row]
        
        return outletCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "OutletVC") as! OutletViewController
        
        vc.resto = self.locationResto[indexPath.row]
        vc.phone = self.phoneResto[indexPath.row]
        
        
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
 


