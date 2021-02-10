//
//  FilterByBrandViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 06/02/21.
//

import UIKit

typealias callback = (String) -> Void

class FilterByBrandViewController: UIViewController {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var filterByBrand: UILabel!
    // Tombol
    @IBOutlet weak var maumereButton: UIButton!
    @IBOutlet weak var freemilkButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    // delegate
    
    var brands: callback?
    
    var userPencet: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI Filter
        filterByBrand.layer.masksToBounds = true
        filterByBrand.layer.cornerRadius = 20
        // UI Done
        doneButton.layer.masksToBounds = true
        doneButton.layer.cornerRadius = 20
        // Ui freemlik sama Maumere
        maumereButton.layer.masksToBounds = true
        maumereButton.layer.cornerRadius = 20
        
        freemilkButton.layer.masksToBounds = true
        freemilkButton.layer.cornerRadius = 20
        // UI viewnya
        
        myView.layer.masksToBounds = true
        myView.layer.cornerRadius = 20
        myView.layer.borderWidth = 3
        myView.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func maumereGotPressed(_ sender: UIButton) {
        userPencet = "maumere"
        maumereButton.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        maumereButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
        freemilkButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        freemilkButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        
        
    }
    
    @IBAction func freemiltGotPressed(_ sender: UIButton) {
     
        userPencet = "freemilt"
        
        maumereButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        maumereButton.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        
        freemilkButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        freemilkButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        
    }
    
    
    
    @IBAction func dismiss(_ sender: UIButton) {
        //Manggil delegate
    
        if let brandCallback = brands{
            if userPencet != nil{
                brandCallback(userPencet!)
            }else{
                brandCallback("Brand")
            }
           
        }
        
        dismiss(animated: true, completion: nil)
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
