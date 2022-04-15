//
//  RegistrationVC.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 13.04.22.
//

import UIKit

class RegistrationVC: UIViewController {
    
    var verificationUrlCode = URL(string: "https://api.malls.team/api/User/SendConfirmEmail")
    var createUser = URL(string: "https://api.malls.team/api/User/CreateUser")
    var urlCountry = URL(string: "https://api.malls.team/api/Location/Country")
    var viewModel = RegViewModel()
    var valid = Validation()
    
    let phoneNumber = "44453212"
    let firstName = "Test211"
    var emailLabel = "test8@mail.ru"
    var passwordLabel = "stringst$"
    let country = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // register()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //sendVerificationCode(url: verificationUrlCode!)
       // register()
    }
    
    // MARK: - Register User
    
    func register() {
        
        let email = valid.isValidEmail(testStr: emailLabel) // change to label.text
        let password = valid.isValidPassword(testStr: passwordLabel) // change to label.text
        
        if email == false || password == false || firstName == "GGGG" || phoneNumber == "2342352345" {
            
            showAlert(title: "ERROR", message: "Somthing wrong!.")
            emailLabel = ""
            passwordLabel = ""
        } else {
            
            createUser(url: createUser!)
            sendVerificationCode(url: verificationUrlCode!)
           
            let storyBoard = UIStoryboard(name: "Registration", bundle: .main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "VerifyVC") as! VerifyVC
            self.present(vc, animated: true)
            //self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - Create User
    
    func createUser(url: URL) {
        viewModel.sendPost(url: url, body: ["phoneNumber": phoneNumber, "firstName": firstName ,"email": emailLabel,"password": passwordLabel, "country": 1]) { response in

                let registerModel = RegisterModel(reg: response)
                print(registerModel)
           // self.sendVerificationCode(url: url)
        }
    }
    
    func sendVerificationCode(url: URL){
        viewModel.sendPost(url: url, body: ["email": emailLabel, "confirmationCode" : 1234]) { response in
            if let parseJson = response as? NSDictionary {
                let mail = parseJson["email"] as? String
                let password = parseJson["confirmationCode"] as? String
            }
        }
    }
}
