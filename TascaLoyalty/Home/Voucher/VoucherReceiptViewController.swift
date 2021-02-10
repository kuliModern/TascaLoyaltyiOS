//
//  VoucherReceiptViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 04/02/21.
//

import UIKit
import SCLAlertView

class VoucherReceiptViewController: UIViewController {

    @IBOutlet weak var sisaPointUser: UILabel!
    @IBOutlet weak var idVoucher: UILabel!
    
    @IBOutlet weak var kembaliKeVoucher: UIButton!
    
    @IBOutlet weak var selamatText: UILabel!
    @IBOutlet weak var instruksiText: UILabel!
    
    var sisapointnya = 0
    var VoucherID: String?
    var JenisVouchernya: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
        //Nerima Value dari sebelumnya
        sisaPointUser.text = String(Int(sisapointnya))
        idVoucher.text = VoucherID
        
        //Testing Purpose
        print(VoucherID)
        
        // Ui text selamat
        selamatText.layer.masksToBounds = true
        selamatText.layer.cornerRadius = 20
        
        selamatText.text = "Selamat!                       Pembelian Voucher \(JenisVouchernya!) Berhasil"
     
        // UI point user
        sisaPointUser.layer.masksToBounds = true
        sisaPointUser.layer.cornerRadius = 20
        
        // Ui Instruksi
        instruksiText.layer.masksToBounds = true
        instruksiText.layer.cornerRadius = 20
        
        // UI Kembali Ke Voucher
        kembaliKeVoucher.layer.cornerRadius = 20
        kembaliKeVoucher.layer.borderWidth = 3
        kembaliKeVoucher.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
            SCLAlertView().showSuccess("Pembelian Voucher Berhasil", subTitle: "Terima kasih telah membeli voucher \(JenisVouchernya!)")
      
           
        }
    
   @IBAction func dismissPressed(_ sender: UIButton) {
        //Unwind Segue
    performSegue(withIdentifier: "unwindToTableView", sender: self)
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


