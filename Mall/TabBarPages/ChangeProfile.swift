//
//  File.swift
//  Mall
//
//  Created by Dmitry Mkrtumov on 17.04.22.
//

import UIKit

class ChangeProfile: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var changeProfileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    //UICOnfig
    func uiConfig() {
        
        //updateButton
        updateButton.layer.borderWidth = 2
        updateButton.layer.borderColor = .init(gray: 0.9, alpha: 1.0)
        updateButton.layer.backgroundColor = .init(red: 1.0, green: 0, blue: 0, alpha: 1.0)
        updateButton.setTitle("Update Profile", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.layer.cornerRadius = 7
        
        //nameTextFiled
        nameTextField.text = "Name"
        nameTextField.textColor = .lightGray
        
        //lastNameTextField
        lastNameTextField.text = "Last Name"
        lastNameTextField.textColor = .lightGray
    }
    
    
    var profile: UserProfileVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        changeProfileImage.addGestureRecognizer(tapGesture)
        changeProfileImage.isUserInteractionEnabled = true
    }
   
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    @IBAction func updateProfileBtn(_ sender: Any){
        NotificationCenter.default.post(name: Notification.Name("text"), object: (nameTextField.text! + " " + lastNameTextField.text!))

//        NotificationCenter.default.post(name: Notification.Name("s"),object: chooseImg.image)

    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]  as? UIImage{
            changeProfileImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

