//
//  AdsDetailCell.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 17.04.22.
//

import UIKit

class AdsDetailCell: UITableViewCell {
    
    @IBOutlet weak var key: UILabel!
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderColor = UIColor.brown.cgColor
        self.contentView.layer.borderWidth = 0.3
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configElements(key: String, value: Any) {
      
        // Test
        self.key.text = key
        self.value.text = "\(value)"
    }
}
