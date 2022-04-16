//
//  MainCollectionViewCell.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 15.04.22.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var vipView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var aboutLbl: UILabel!
    
    override func prepareForReuse() {
        imageView.image = UIImage(named: "mall")
        priceLbl.text = ""
        aboutLbl.text = ""
        super.prepareForReuse()
    }
    
    // MARK: - Config Vip image view
    
    func configVipImageView(isVip: Bool) {
        
        if isVip {
            vipView.layer.cornerRadius = 10
            vipView.clipsToBounds = true
            vipView.isHidden = false
            vipImageView.isHidden = false
        } else {
            vipView.isHidden = true
            vipImageView.isHidden = true
        }
    }
}
