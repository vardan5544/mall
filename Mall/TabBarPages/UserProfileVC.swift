//
//  UserProfileVC.swift
//  Mall
//
//  Created by Dmitry Mkrtumov on 16.04.22.
//

import UIKit

class UserProfileVC: UIViewController {
    
    //outlets
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileDataBackground: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var accauntDataBackground: UILabel!
    @IBOutlet weak var tableViewUserProfileVC: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    //actions
    @IBAction func logoutButton(_ sender: Any) {
        print("Logout!")
    }
    
    
    // properties
    var textArrays = [
        "Update profile", "Reset password", "My adds", "Messenger"
    ]
    
    @objc func didGetNotification(_ notification: Notification){
        let name = notification.object as! String
        nameLabel.text = name
    }
    
    //Outlets UI configurations
    func uiConfig () {
        // profileLabel config
        profileLabel.textColor = .black
        profileLabel.layer.backgroundColor = CGColor(red: 1.0, green: 0, blue: 0.1, alpha: 0.9)
        profileLabel.text = "Profile"
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
        
      
    }// uiConfig

    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()
        tableViewUserProfileVC.dataSource = self
        tableViewUserProfileVC.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
    }

}// UserProfileVC class


extension UserProfileVC: UITableViewDataSource, UITableViewDelegate {
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableViewUserProfileVC.dequeueReusableCell(withIdentifier: "profileCell1111`")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "profileCell1111")
        }
        
        cell!.textLabel?.text = textArrays[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == 0 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let changeProfileVc = storyBoard.instantiateViewController(withIdentifier: "changeProfile") as! ChangeProfile
            //present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(changeProfileVc, animated: true)
            changeProfileVc.getProfileImageClosure = { [weak self] image in
                self?.profileImage.image = image
            }
            
        } /*else if index == 2 {
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           let addsVc = storyBoard.instantiateViewController(withIdentifier: "myAdds") as! MyAddsVC
           self.navigationController?.pushViewController(addsVc, animated: true)
        }*/
        
    }
}// tablewView extension

