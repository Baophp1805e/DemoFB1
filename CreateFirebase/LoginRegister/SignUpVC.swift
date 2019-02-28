//
//  SignUpVC.swift
//  CreateFirebase
//
//  Created by Ominex on 2/11/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var tabToChangeProfileButton: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var ref: DatabaseReference!
    var activityView:UIActivityIndicatorView!
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        guard
        let username = txtUsername.text,
            username != "",
        let email = txtEmail.text,
            email != "",
        let password = txtPassword.text,
            password != ""
        
        else
        {
            AlertController.showAlert(inViewController: self, title: "Alert", message: "Please fill out all fields.")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            // ...
            if(user != nil)
            {
                
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
                print(" Register success !")
            }
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            
            changeRequest?.commitChanges { error in
            if(error != nil)
            {
                AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
            }
            }}
        
        self.UploadImg()
    }
    
    
    
    @IBAction func avatarPicTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)    }
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
 
    func AddUser(profilePicLink url : String) {
        ref = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid)
        let AddUser = ["username": txtUsername.text!, "email":txtEmail.text!, "profilePicLink": url] as [String: String]
        ref.setValue(AddUser)
    }
    
    func UploadImg(){
        let storageRef = Storage.storage().reference().child("usersProfilePics").child((Auth.auth().currentUser?.uid)!)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.putData((profilePic.image!.jpegData(compressionQuality: 0.1))!, metadata: metadata, completion: { (metadata, err) in
            if err == nil {
                storageRef.downloadURL { url, error in
                    self.AddUser(profilePicLink: (url?.absoluteString)!)
                }
            }
        })
    }
    
}


extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profilePic.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
