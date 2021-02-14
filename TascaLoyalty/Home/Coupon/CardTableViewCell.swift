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
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        myImageVIew.layer.masksToBounds = true
        myImageVIew.layer.cornerRadius = 20
       
    }
//    override class func awakeFromNib() {
//        super.awakeFromNib()
//        gambarPromo.showAnimatedSkeleton()
//
//    }
    

}
