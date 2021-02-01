//
//  CardTableViewCell.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 30/01/21.
//

import UIKit
import ViewAnimator

class CardTableViewCell: UITableViewCell {

   
    @IBOutlet weak var myImageVIew: UIImageView!
    @IBOutlet weak var namaRestoran: UILabel!
    @IBOutlet weak var jenisDiskon: UILabel!
    @IBOutlet weak var durasiDiskon: UILabel!
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    

}
