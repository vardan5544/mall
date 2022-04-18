//
//  AdImageViewCell.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 17.04.22.
//

import UIKit

class AdImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var adImageView: UIImageView!
    
    override class func awakeFromNib() {
        
    }
    
    func setupimage(url: String?) {
        
        guard let url = URL(string: url!) else {
            
            adImageView.image = UIImage(systemName: "photo.artframe")
            return }
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            self.adImageView.af.setImage(withURL: url)
        }
    }
}
