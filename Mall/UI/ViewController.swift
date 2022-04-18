//
//  ViewController.swift
//  Mall
//
//  Created by Hakobjanyan Vardan on 12.04.22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    
    
    // vars and constants
    var valid = Validation()
    var networkService = NetworkingService()
    var loginUSer: LoginModel!
    
    var urlString = URL(string: api + "/api/Identity/Login")
    
    //Actions
    @IBAction func loginButtonEvent(_ sender: Any) {
        
        let email = valid.isValidEmail(testStr: emailField.text!)
        let password = valid.isValidPassword(testStr: passwordField.text!)
        if email == false || password == false{
            valid.showAlert(title: "ERROR", message: "This is not a valid email. Please try again.")
            emailField.text = ""
            passwordField.text = ""
        }else{
            networkService.loginPostRequest(url: urlString!, body: ["userName": emailField.text, //"georgi20111@gmail.com",//
                                                                    "password": passwordField.text,//"123123123"
                                                                    "token": ""])  { [self] (result)in
                switch result{
                case .success(let response):
                    loginUSer = response.self
                    DispatchQueue.main.async {
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "myTabBar") as! MyTabBar
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                case .failure(let error):
                    print("error", error)
                }
            }
//            showAlert(title: "ERROR", message: "Email or password isnt valid")
        }
    }
    
    
    
    // UI config
    
    func UIConfigurations() {
     
        let mallImage = UIImage(named: "mall-1")!
        logoImg.image = mallImage
       
        
        //ForgotPassword button config
        forgotPassword.setTitle("Forgot password", for: .normal)
        forgotPassword.tintColor = .green
        
        //Login button config
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.backgroundColor = .red
        
        //Register button config
        registerButton.setTitle("Registration", for: .normal)
        
        //emailField
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        UIConfigurations()
    }
}

