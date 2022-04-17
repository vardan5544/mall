//
//  UserProfileVC.swift
//  Mall
//
//  Created by Dmitry Mkrtumov on 16.04.22.
//

import UIKit

class UserProfileVC: UIViewController {
    
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileDataBackground: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var accauntDataBackground: UILabel!
    
    @IBOutlet weak var updateProfileLabel: UILabel!
    @IBOutlet weak var resetPasswordLabel: UILabel!
    @IBOutlet weak var myAddsLabel: UILabel!
    @IBOutlet weak var messengerLabel: UILabel!
    
    
    
    
    
    // properties
    var textArrays = [
            "Profile", "Logout"
    ]
    
    
    //Outlets UI configurations
    func uiConfig () {
        // profileLabel config
        profileLabel.textColor = .black
        profileLabel.layer.backgroundColor = CGColor(red: 1.0, green: 0, blue: 0.1, alpha: 0.9)
        profileLabel.text = textArrays[0]
        profileLabel.layer.cornerRadius = 7
        profileLabel.layer.borderWidth = 1
        profileLabel.layer.borderColor = CGColor(gray: 0.4, alpha: 0.4)
        
        //logoutButton config
        logoutButton.backgroundColor = .opaqueSeparator
        logoutButton.tintColor = .black
        //logoutButton.setImage(UIImage(named: "Logout"), for: .normal)
        logoutButton.setTitle("", for: .normal)
        logoutButton.layer.cornerRadius = 5.0
        
        //profileDataBackground
        profileDataBackground.backgroundColor = .white
        profileDataBackground.layer.borderWidth = 1
        profileDataBackground.layer.borderColor = CGColor(gray: 0.4, alpha: 0.4)
        profileDataBackground.layer.cornerRadius = 7


        
        //profileImage
        profileImage.layer.shadowRadius = 0.1
        profileImage.layer.shadowOpacity = 0.1
        
        //accountDataBackground
        accauntDataBackground.layer.borderWidth = 1
        accauntDataBackground.layer.borderColor = CGColor(gray: 0.4, alpha: 0.4)
        accauntDataBackground.layer.cornerRadius = 7
        
        //updateProfileLabel
        updateProfileLabel.layer.borderWidth = 1
        updateProfileLabel.layer.borderColor = CGColor(gray: 0.4, alpha: 0.4)
        updateProfileLabel.layer.cornerRadius = 7
        
        //resetPasswordLabel
        resetPasswordLabel.layer.borderWidth = 1
        resetPasswordLabel.layer.borderColor = CGColor(gray: 0.4, alpha: 0.4)
        resetPasswordLabel.layer.cornerRadius = 7
        
        //myAddsLabel
        myAddsLabel.layer.borderWidth = 1
        myAddsLabel.layer.borderColor = CGColor(gray: 0.4, alpha: 0.4)
        myAddsLabel.layer.cornerRadius = 7
        
        //messengerLabel
        messengerLabel.layer.borderWidth = 1
        messengerLabel.layer.borderColor = CGColor(gray: 0.4, alpha: 0.4)
        messengerLabel.layer.cornerRadius = 7
        
    }
    
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()
    }
    
    
    
    

    
}// UserProfileVC class


