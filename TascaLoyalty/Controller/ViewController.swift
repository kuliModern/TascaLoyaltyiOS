//
//  ViewController.swift
//  TascaLoyalty
//
//  Created by Azka Kusuma Edy on 20/01/21.
//

import UIKit

class ViewController: UIViewController{

    
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var daftarButton: UIButton!
    @IBOutlet weak var masukButton: UIButton!
    var images = [
        
        UIImage(named: "NearMe"),
        UIImage(named: "Promo"),
        UIImage(named: "Voucher")
        
]
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        // round corner
        daftarButton.layer.cornerRadius = 35
        masukButton.layer.cornerRadius = 35
        // Outer Color
        masukButton.layer.borderWidth = 3
        masukButton.layer.borderColor = #colorLiteral(red: 0.9999516606, green: 0.8314109445, blue: 0.0001840102777, alpha: 1)
    }
    
    @objc func changeImage() {
     
     if counter < images.count {
         let index = IndexPath.init(item: counter, section: 0)
         self.myCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.myCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
       
         counter = 1
     }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = images[indexPath.row]
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}



