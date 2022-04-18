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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configElements(key: String, value: Any) {
        
            
            self.key.text = key
            self.value.text = "\(value)"
    }
    
}
