//
//  AfterPressedViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 30/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class AfterPressedViewController: ViewController {
    // Image
    @IBOutlet weak var MyImage: UIImageView!
    // Coupon Desc
    @IBOutlet weak var namaRestoran: UILabel!
    @IBOutlet weak var jenisDiskon: UILabel!
    @IBOutlet weak var durasiDiskon: UILabel!

    //Label
   
    @IBOutlet weak var descPromo: UILabel!
    @IBOutlet weak var testingHowTouse: UILabel!
    
    // Table View
    
    @IBOutlet weak var tableviewOutlet: UITableView!
   
    // Button Restaurant Redirect
    
    @IBOutlet weak var goToRestaurantButton: UIButton!
    
    
    //Button
    @IBOutlet weak var DescButton: UIButton!
    @IBOutlet weak var howToUseButton: UIButton!
    @IBOutlet weak var outletButton: UIButton!
    
    // array parsing faris
    
    var outletPromo = [String]()
    var phoneNum = [String]()
    
    // variable
    
    var gambarRestoran = UIImage()
    var namaRestorannya = ""
    var jenisDiskonRestoran = ""
    var durasiDiskonRestoran = ""
    var descPromonya = ""
    
    // Restoran Status
    
    var restoStatus: String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI Button
        testingHowTouse.isHidden = true
        descPromo.isHidden = false
        tableviewOutlet.isHidden = true
        
        // Go To Restaurant UI
        goToRestaurantButton.layer.cornerRadius = 40
        goToRestaurantButton.layer.masksToBounds = true
        if restoStatus == "Grab" || restoStatus ==  "Gojek"{
            print("true")
            goToRestaurantButton.isHidden = false
        }else{
            print("false")
            goToRestaurantButton.isHidden = true
        }
     
       
        
        // Restaurant Button
        
        
        DescButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        // Do any additional setup after loading the view.
        // Value from Coupon View
        // Gambar Restorannya
        MyImage.image = gambarRestoran
        // Text Valuenya
        namaRestoran.text = namaRestorannya
        jenisDiskon.text = jenisDiskonRestoran
        durasiDiskon.text = durasiDiskonRestoran
        descPromo.text = descPromonya
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Description button Pressed
        // Button Color
        DescButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        howToUseButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        outletButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        // Text
        descPromo.isHidden = false
        testingHowTouse.isHidden = true
        tableviewOutlet.isHidden = true
        
    }
    
    @IBAction func howToUsePressed(_ sender: UIButton) {
        //Button Color
        DescButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        howToUseButton.setTitleColor(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), for: .normal)
        outletButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        // Text
        descPromo.isHidden = true
        testingHowTouse.isHidden = false
        tableviewOutlet.isHidden = true
        
    }
    
    @IBAction func outletPressed(_ sender: UIButton) {
        // Description button Pressed
        // Button Color
        DescButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        howToUseButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        outletButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        
        descPromo.isHidden = true
        testingHowTouse.isHidden = true
        tableviewOutlet.isHidden = false
        // nembak ke faris buat outlet
        
        
        let urlString   = "\(url.linkFaris)/api/getbranch?restaurant_name=\(namaRestorannya)"
        
        
         AF.request(urlString, method: .get, encoding:  URLEncoding.queryString).responseJSON { response in
           switch response.result {
           case .success(let value):
            
             
             print("Validation Successful")
             print(response)
             let json = JSON(value)
             
             let counting = json["branch"].count
           
            for x in 0...counting - 1{
                
                // Location
                var location = json["branch"][x]["location"].stringValue
                self.outletPromo.append("\(location)")
                
                
                // No Telfon restorannya
                var notelp = json["branch"][x]["phone_number"].stringValue
                self.phoneNum.append("\(notelp)")
            }
            
           
             
           case let .failure(error):
             
             print(error)
            
           }
            self.tableviewOutlet.reloadData()
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

extension AfterPressedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return outletPromo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let op = tableView.dequeueReusableCell(withIdentifier: "OutletPromo", for: indexPath) as! OutletPromoTableViewCell
        
        op.OutletPromo.text = outletPromo[indexPath.row]
       
        return op
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let outlet = storyboard?.instantiateViewController(identifier: "OutletPromoLocationandPhone") as! OutletPromoViewController
        
        outlet.restoText = outletPromo[indexPath.row]
        outlet.restoTelp = phoneNum[indexPath.row]
        
        self.navigationController?.pushViewController(outlet, animated: true)
    }
    
}
