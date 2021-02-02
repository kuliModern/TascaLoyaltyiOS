//
//  CardVoucherTableViewCell.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 02/02/21.
//

import UIKit

class CardVoucherTableViewCell: UITableViewCell {


    @IBOutlet weak var gambarRestoran: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var namaRestoran: UILabel!
    @IBOutlet weak var jenisVoucher: UILabel!
    @IBOutlet weak var durasiVoucher: UILabel!
    @IBOutlet weak var hargaVoucher: UILabel!
    @IBOutlet weak var dapatkanVoucher: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        // Shadownya dan Cell-nya
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        cardView.layer.shadowOpacity = 1
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 2.0
        
        dapatkanVoucher.layer.cornerRadius = 5
        hargaVoucher.layer.masksToBounds = true
        hargaVoucher.layer.cornerRadius = 30
    }

}
