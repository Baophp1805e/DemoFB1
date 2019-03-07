//
//  UpdateProViewController.swift
//  CreateFirebase
//
//  Created by Ominex on 2/28/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Kingfisher

class UpdateProViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btnCancle: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtGmail: UITextField!
    @IBOutlet weak var lblGmail: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var lblUsername: UILabel!
    let imagePickerController = UIImagePickerController()
    
    
    func Custom() {
        CustomImg()
        CustomTextField()
        CustomButton()
    }
    
    func CustomButton()  {
        btnSave.makeRoundedBorder(radius: 20)
        btnCancle.makeRoundedBorder(radius: 20)
    }
    func CustomImg(){
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height/2
        imgProfile.clipsToBounds = true
    }
    
    func CustomTextField() {
        txtGmail.layer.masksToBounds = true
        txtGmail.layer.cornerRadius = 20
        txtUsername.layer.masksToBounds = true
        txtUsername.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataProfile()
        Custom()
    }
    @IBAction func imgTapped(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
   
    @IBAction func btnCan(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
        let storageRef = Storage.storage().reference().child("usersProfilePics").child((Auth.auth().currentUser?.uid)!)
        let metadata = StorageMetadata()
        if imgProfile != nil {
            metadata.contentType = "image/jpeg"
            storageRef.putData((imgProfile.image!.jpegData(compressionQuality: 0.1))!, metadata: metadata, completion: { (metadata, err) in
                if err == nil {
                    storageRef.downloadURL { url, error in Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["username": self.txtUsername.text!,"email": self.txtGmail.text as Any, "profilePicLink":url!.absoluteString]) 
                    }
                     self.dismiss(animated: true, completion: nil)
                }
                //        })
            })
        }
       
    }
    func getDataProfile(){
        Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!).observe(.value) { (snapshot) in
            if snapshot.exists(){
//            print(snapshot)
            let avatar = (snapshot.value as! NSDictionary)["profilePicLink"] as! String
            let name = (snapshot.value as! NSDictionary)["username"] as! String
            let email = (snapshot.value as! NSDictionary)["email"] as! String
            self.txtUsername.text = name
            self.txtGmail.text = email
            self.imgProfile.kf.setImage(with: URL(string: avatar))
            }
            
        }
    }
}

extension UpdateProViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgProfile.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

