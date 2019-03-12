//
//  YourPostVC.swift
//  CreateFirebase
//
//  Created by Bao on 2/14/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit
import Firebase

class YourPostVC: UIViewController, UITextViewDelegate {
    //MARK: Properties
    var ref: DatabaseReference!
    weak var protocolPost: PostProtocol?
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var lbluser: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func btnPost(_ sender: Any) {
        UploadImg()
    }
    func AddData(imgPostLink url: String){
        protocolPost?.didClickPost()
        let refPost = Database.database().reference().child("Post").childByAutoId()
        let keyPost = refPost.key
        let timeStamp = Int(Date().timeIntervalSince1970)
        let AddData = ["id":keyPost!, "uid":Auth.auth().currentUser?.uid as Any, "status":textView.text!, "imgPost": url,"timeStamp":timeStamp,"countLikes":"0"] as [String : Any]
        refPost.setValue(AddData)
        { (error: Error?, ref: DatabaseReference) in
            if (error == nil) {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let close = storyBoard.instantiateViewController(withIdentifier: "NewFeedVC")
                self.navigationController?.pushViewController(close, animated: true)
            } else {
//                self.postlist = []
                
            }
        }
        let value = [keyPost: "post"] as! [String: String]
    Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!).child("Post").updateChildValues(value)
    }
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        textView.delegate = self
//        getDataName()
    }
    
    // MARK: - Handle
    @IBAction func btnCancle(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let close = storyBoard.instantiateViewController(withIdentifier: "NewFeedVC")
        navigationController?.pushViewController(close, animated: true)
    }
    
    @IBAction func imgPostTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func UploadImg(){
        let storageRef = Storage.storage().reference().child("usersProfilePics").child((Auth.auth().currentUser?.uid)!)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.putData((imgPost.image!.jpegData(compressionQuality: 0.1))!, metadata: metadata, completion: { (metadata, err) in
            if err == nil {
                storageRef.downloadURL { url, error in
                    self.AddData(imgPostLink: (url?.absoluteString)!)
                }
            }
        })
    }
}

 

extension YourPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgPost.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
