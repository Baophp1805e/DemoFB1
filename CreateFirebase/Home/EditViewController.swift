//
//  EditViewController.swift
//  CreateFirebase
//
//  Created by Bao on 3/8/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import Kingfisher

class EditViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tfPost: UITextField!
    let imagePickerController = UIImagePickerController()
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    var ref: DatabaseReference!
    var infor : Infor?{
        didSet {
//            getComment()
        }
    }
    
    func custom(){
        imgAvatar.layer.masksToBounds = true
        imgAvatar.layer.cornerRadius = imgAvatar.frame.height/2
        btnSave.makeRoundedBorder(radius: 20)
        tfPost.layer.masksToBounds = true
        tfPost.layer.cornerRadius = 20
        
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        custom()
        userName.text = infor?.user?.userM
        if infor?.user?.userM != userName.text {
            
        }
        imgAvatar.kf.setImage(with: URL(string: (infor?.user?.logoUserM)!))
        
        let messageDate = Date(timeIntervalSince1970: TimeInterval((infor?.post?.timeStamp)!))
        let dataformatter = DateFormatter()
        dataformatter.timeStyle = .short
        let date = dataformatter.string(from: messageDate)
        timeStamp.text = date
        
        tfPost.text = infor?.post?.postTextM
        imgPost.kf.setImage(with: URL(string: (infor?.post?.imgPostM)!))
    }
    
    //MARK: Handle
    @IBAction func btnCancel(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newFeedVC = storyBoard.instantiateViewController(withIdentifier: "NewFeedVC") as! NewFeedVC
        self.navigationController?.pushViewController(newFeedVC, animated: true)
    }
    
    
    @IBAction func btnImgPostTapped(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let storageRef = Storage.storage().reference().child("imgPostPic").child((Auth.auth().currentUser?.uid)!)
        let metadata = StorageMetadata()
        if imgPost != nil {
            metadata.contentType = "image/jpeg"
            storageRef.putData((imgPost.image!.jpegData(compressionQuality: 0.1))!, metadata: metadata, completion: { (metadata, err) in
                if err == nil {
                    storageRef.downloadURL { url, error in Database.database().reference().child("Post").child((self.infor?.post?.idM)!).updateChildValues(["status": self.tfPost.text!, "imgPost":url!.absoluteString])
                    }
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let newFeedVC = storyBoard.instantiateViewController(withIdentifier: "NewFeedVC") as! NewFeedVC
                    self.navigationController?.pushViewController(newFeedVC, animated: true)
                }
            })
        }
    }
}

extension EditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imgPost.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
