//
//  AdsDetailVC.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 16.04.22.
//

import UIKit

class AdsDetailVC: UIViewController {
    
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var ads: Ads?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configElements()
    }
    
    // MARK: - Config ads elements from data
    
    func configElements() {
        
        guard let ads = ads else { return }

        self.titleLabel.text = ads.name
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            
            if ads.image != "" {
                
                if let data = try? Data(contentsOf: URL(string: ads.image)!) {
                self.adImageView.image = UIImage(data: data)
                }
                
            } else if ads.image == "" {
                
                self.adImageView.image = UIImage(systemName: "photo.artframe")
                self.adImageView.tintColor = UIColor.gray
            }
        }
        print(ads.name, "Ads Page Print")
    }
    
    func configAds(ads: Ads) {
        self.ads = ads
    }
}
