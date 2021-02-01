//
//  AfterPressedViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 30/01/21.
//

import UIKit

class AfterPressedViewController: ViewController {
    // Image
    @IBOutlet weak var MyImage: UIImageView!
    // Coupon Desc
    @IBOutlet weak var namaRestoran: UILabel!
    @IBOutlet weak var jenisDiskon: UILabel!
    @IBOutlet weak var durasiDiskon: UILabel!

    //Label
    @IBOutlet weak var testingDesc: UILabel!
    @IBOutlet weak var testingHowTouse: UILabel!
    
    //Button
    @IBOutlet weak var DescButton: UIButton!
    @IBOutlet weak var howToUseButton: UIButton!
    // variable
    
    var gambarRestoran = UIImage()
    var namaRestorannya = ""
    var jenisDiskonRestoran = ""
    var durasiDiskonRestoran = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI Button
        testingHowTouse.isHidden = true
        testingDesc.isHidden = false
        DescButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        // Do any additional setup after loading the view.
        // Value from Coupon View
        // Gambar Restorannya
        MyImage.image = gambarRestoran
        // Text Valuenya
        namaRestoran.text = namaRestorannya
        jenisDiskon.text = jenisDiskonRestoran
        durasiDiskon.text = durasiDiskonRestoran
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Description button Pressed
        // Button Color
        DescButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        howToUseButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        // Text
        testingDesc.isHidden = false
        testingHowTouse.isHidden = true
        
    }
    
    @IBAction func outletPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func howToUsePressed(_ sender: UIButton) {
        //Button Color
        DescButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        howToUseButton.setTitleColor(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), for: .normal)
        // Text
        testingDesc.isHidden = true
        testingHowTouse.isHidden = false
        
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
