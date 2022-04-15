//
//  MainCollectionViewCell.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 15.04.22.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
        
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var priceLbl: UILabel!
        @IBOutlet weak var aboutLbl: UILabel!
    
    override func prepareForReuse() {
        imageView.image = UIImage(named: "mall")
        priceLbl.text = ""
        aboutLbl.text = ""
        super.prepareForReuse()
    }
}
