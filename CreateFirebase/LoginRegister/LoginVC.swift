//
//  LoginVC.swift
//  CreateFirebase
//
//  Created by Ominex on 2/11/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    
    func customButton(){
        
        btnLogin.makeRoundedBorder(radius: 20)
        btnRegister.makeRoundedBorder(radius: 20)
    }
    
    func customTextField(){
        txtEmail.layer.masksToBounds = true
        txtEmail.layer.cornerRadius = 20
        txtPassword.layer.masksToBounds = true
        txtPassword.layer.cornerRadius = 20
//        txtEmail.customBorder(radius: 20)
//        txtPassword.customBorder(radius: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTextField()
        customButton()
    }
    @IBAction func btnLogin(_ sender: Any) {
        guard let email = txtEmail.text, email != "",
            let password = txtPassword.text, password != ""
            
            else
        {
            AlertController.showAlert(inViewController: self, title: "Alert", message: "Please fill out all fields.")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            // ...
            if(user != nil)
            {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            if(error != nil)
            {
                AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
            }
        }
    }
    
    
}
