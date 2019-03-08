//
//  NewFeedVC.swift
//  CreateFirebase
//
//  Created by Bao on 2/14/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NewFeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//    var isChecked = true
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Property
    var ref: DatabaseReference!
    var postlist = [Infor]()
   
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NewFeed"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 214
        let nibName = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "cell")
        obj()
    }
 
    func obj(){
        ref = Database.database().reference()
        ref.child("Post").queryLimited(toLast: 10).observe(.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.postlist.removeAll()
                for child in snapshot.children {
                    let infor = Infor()
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String:Any]
                    let id = dict["id"] as! String
                    let status = dict["status"] as! String
                    let imgPost = dict["imgPost"] as! String
                    let timestamp = dict["timeStamp"] as! Int
                    let uid = dict["uid"] as! String
                    let countLikes = dict["countLikes"] as! String
                    print(countLikes)
                    let post = Post(id: id, imgPost: imgPost, uid: uid, post: status, timeStamp: timestamp, countLikes:countLikes)
                    infor.post = post
                    self.ref.child("Users").child(uid).observe(.value, with: { (data) in
                        if data.childrenCount > 0{
                            
                            let dict = data.value as! [String: Any]
                            let profilePicLink = dict["profilePicLink"] as! String
                            let username = dict["username"] as! String
                            let user = UserProfile(logoUser: profilePicLink, user: username)
                            infor.user = user
                            if self.postlist.count > 0 {
                                for i in 0 ..< self.postlist.count {
                                    if self.postlist[i].post?.idM == infor.post?.idM {
                                        self.postlist.remove(at: i)
                                        break
                                    }
                                }
                            }

                            self.postlist.append(infor)
                            self.postlist.sort{ $0.post!.timeStamp! > $1.post!.timeStamp! }
                             self.tableView.reloadData()
                        }
                        
                    })
                    self.tableView.reloadData()
                    
                }
            }
        }
    }

    //MARK: - Handle
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        let data = postlist[indexPath.row]
        cell.set(infor: postlist[indexPath.row])
        cell.showImgPost.kf.setImage(with: URL(string: (data.post?.imgPostM)!))
        cell.logoImage.kf.setImage(with: URL(string: (data.user?.logoUserM)!))
        cell.logoImage.layer.masksToBounds = true
        cell.logoImage.layer.cornerRadius = cell.logoImage.frame.width/2
        let messageDate = Date(timeIntervalSince1970: TimeInterval((data.post?.timeStamp)!))
        let dataformatter = DateFormatter()
        dataformatter.timeStyle = .short
        let date = dataformatter.string(from: messageDate)
        cell.timeLabel.text = date
        cell.lblCountLikes.text = postlist[indexPath.row].post?.countLikes
        cell.delegate = self
        cell.delegateST = self
        cell.delegateLike = self
        cell.indexPath = indexPath
        cell.postID = postlist[indexPath.row].post?.idM
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func updateDemo(id: String, userUpdate: String, postUpdate: String)
//    {
//        let timeStamp = NSNumber.init(value: Date().timeIntervalSince1970)
//        let data = ["id" : id, "username" : userUpdate, "status" : postUpdate,"timeStamp":timeStamp] as [String : Any]
//        ref.child("Post").child(id).setValue(data)
//
//    }
////
//    func deleteDemo(id: String)
//    {
//        ref.child("Users").child((Auth.auth().currentUser?.uid)!).child("Post").child(id).removeValue()
//            ref.child("Post").child(id).removeValue()
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let demo = postlist[indexPath.row]
//        let alertController = UIAlertController(title:demo.user!.userM, message: "Give new values to demo", preferredStyle:.alert)
//
//        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
//            let id = demo.post!.idM
//            let userUpdate = alertController.textFields?[0].text
//            let postUpdate = alertController.textFields?[1].text
//
//            self.updateDemo(id: id!, userUpdate: userUpdate!, postUpdate: postUpdate!)
//        }
//        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (_) in
//
//            self.deleteDemo(id: demo.post!.idM!)
//            self.postlist.remove(at: indexPath.row)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
//            print("Cancel button tapped");
//        }
//        alertController.addTextField { (textField) in
//            textField.text = demo.user!.userM
//        }
//        alertController.addTextField { (textField) in
//            textField.text = demo.post!.postTextM
//        }
//
//        alertController.addAction(cancelAction)
//        alertController.addAction(updateAction)
//        alertController.addAction(deleteAction)
//        present(alertController, animated: true, completion: nil)
//    }
}


extension NewFeedVC: PostDelegate{
    func didClickComment(indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let commentVc = storyBoard.instantiateViewController(withIdentifier: "commentVC") as? CommentViewController
//        print(postlist[indexPath.row].post?.idM)
        commentVc?.post = postlist[indexPath.row].post
        
        self.navigationController?.pushViewController(commentVc!, animated: true)
    }
    
    
}

extension NewFeedVC: SettingDelegate{
    func didClickSetting(indexPath: IndexPath) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopoverViewController
        self.addChild(popOverVC)
        popOverVC.delegateDelete = self
        popOverVC.editDelegate = self
        popOverVC.idPost = self.postlist[indexPath.row].post?.idM
        popOverVC.view.frame = self.view.frame
        popOverVC.indexpath = indexPath
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
}

extension NewFeedVC: EditDelegateProtocol{
    func didClickEdit(idPost: String,indexPath: IndexPath) {
        print("Edit")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let commentVc = storyBoard.instantiateViewController(withIdentifier: "Edit") as? EditViewController
        commentVc?.infor = postlist[indexPath.row]
        self.navigationController?.pushViewController(commentVc!, animated: true)
    }
}

extension NewFeedVC: LikeDelegate{

     func clickLike(indexPath: IndexPath) {
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }

}

extension NewFeedVC: DeleteDelegate{
    func didClickDelete(idPost: String) {
        print("Delete")
        ref.child("Post").child(idPost).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            } else {
                
            }
            self.tableView.reloadData()
        }
        ref.child("Users").child((Auth.auth().currentUser?.uid)!).child("Post").child(idPost).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            } else {
                
            }
            self.tableView.reloadData()
        }
        ref.child("Comment").child(idPost).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            } else {
                
            }
            self.tableView.reloadData()
        }
//        self.tableView.reloadData()
    }
}
    

