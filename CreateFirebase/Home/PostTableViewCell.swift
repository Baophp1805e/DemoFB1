//
//  PostTableViewCell.swift
//  CreateFirebase
//
//  Created by Bao on 2/13/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {
     // MARK: - Property
    @IBOutlet weak var lblCountLikes: UILabel!
    @IBOutlet weak var showImgPost: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    var indexPath: IndexPath!
    var postID: String!
    weak var delegate: PostDelegate?
    weak var delegateST: SettingDelegate?
    weak var delegateLike: LikeDelegate?
    //MARK: Life cycle
  
    override func awakeFromNib() {
        super.awakeFromNib()
        imgHeart.image = UIImage(named: "btn_heart_red_solid")
    }
    
    // MARK: - Handle
    func checkLike() {
        self.isHidden = true
        imgHeart.image = UIImage(named: "btn_heart_red_solid")
    }
        
    @IBAction func btnLike(_ sender: UIButton) {
        delegateLike?.clickLike(indexPath: self.indexPath)
        Database.database().reference().child("Post").child(postID).child("UserLike").observe(.value) { (snapshot) in
            print(snapshot.childrenCount)
            let like = Database.database().reference().child("Post").child(self.postID)
            like.updateChildValues(["countLikes":"\(snapshot.childrenCount)"])
        }
        guard let loopButton = sender as? UIButton else {
            return
        }
        
        let selected = !loopButton.isSelected
        
        if selected {
            print("selected")
            
            let like = Database.database().reference().child("Post").child(postID)
            like.child("UserLike").updateChildValues([(Auth.auth().currentUser?.uid)! : true])
            imgHeart.image = UIImage(named: "btn_heart_red_solid")
            
        } else {
            print("deselected")
            let like = Database.database().reference().child("Post").child(postID)
            like.child("UserLike").child((Auth.auth().currentUser?.uid)!).removeValue()
            imgHeart.image = UIImage(named: "btn_heart_black_outline")
        }
        
        loopButton.isSelected = selected
    }
    
    @IBAction func btnST(_ sender: Any) {
        delegateST?.didClickSetting(indexPath: self.indexPath)
        print("Setting tapped")
    }
    
    @IBAction func btnComment(_ sender: Any) {
        
        delegate?.didClickComment(indexPath: self.indexPath)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func  set(infor:Infor) {
        postLabel.text = infor.post!.postTextM
        userLabel.text = infor.user!.userM
        
    }
    
}
