//
//  CommentViewController.swift
//  CreateFirebase
//
//  Created by Bao on 3/5/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var CMT = [Infor]()
    var ref: DatabaseReference!
    var cmtList : Post?{
        didSet {
            getComment()
        }
    }
    
    @IBOutlet weak var textComment: UITextField!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        settingCmt()
        self.title = "Comment"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - Handle
    
    func getComment(){
        Database.database().reference().child("Comment").child((cmtList?.idM)!).observe(.value) { (dataSnapshot) in
            if dataSnapshot.childrenCount > 0{
//                print(dataSnapshot)
                self.CMT.removeAll()
                for child in dataSnapshot.children{
                    let infor = Infor()
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String:Any]
                    let uid = dict["id"] as! String
                    let textComment = dict["textComment"] as! String
                    let time = dict["timeStamp"] as! NSNumber
                    let cmt = CommentModel(uid: uid, cmt: textComment, timeStamp: time)
                    infor.cmtInfor = cmt
//                    print(uid)
                    Database.database().reference().child("Users").child(uid).observe(.value, with: { (data) in
//                        print(data)
                        let dict = data.value as! [String: Any]
                        let profilePicLink = dict["profilePicLink"] as! String
                        let username = dict["username"] as! String
                            let user = UserProfile(logoUser: profilePicLink, user: username )
                            infor.user = user
                            self.CMT.append(infor)
                            self.tableView.reloadData()
            })
                }
                }
        }
    }
    
    @IBAction func btnSend(_ sender: Any) {
        if textComment.text != "" {
            AddData()
            textComment.text = ""
        }
    }
    
    func AddData(){
        let refCmt = Database.database().reference().child("Comment").child((cmtList?.idM)!).childByAutoId()
        let keyCmt = refCmt.key
//        print(keyCmt)
        
        
        let timeStamp = NSNumber.init(value: Date().timeIntervalSince1970)
        
        let values : [String: Any] = ["id":Auth.auth().currentUser?.uid as Any,"textComment":textComment.text!,"timeStamp":timeStamp]
        refCmt.setValue(values)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CMT.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let data = CMT[indexPath.row]
        cell.lblCmt.text = data.cmtInfor!.cmtM
        cell.lblUsername.text = data.user!.userM
        cell.avtUser.kf.setImage(with: URL(string: (data.user?.logoUserM)!))
        cell.avtUser.layer.masksToBounds = true
        cell.avtUser.layer.cornerRadius = cell.avtUser.frame.height/2
        let exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: (data.cmtInfor?.timeStamp)!))
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "hh:mm a"
        cell.lblTimer.text = dateFormatt.string(from: exactDate as Date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let cmt = Database.database().reference().child("Comment").child((cmtList?.idM)!)
////        print(cmt)
//        let keyCMT = cmt.key
//        print(keyCMT)
        if (editingStyle == .delete) {
//            self.CMT.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
    Database.database().reference().child("Comment").child((cmtList?.idM)!).removeValue()
        }
        
    }
//    func settingCmt() {
//        let editAction =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
//            //do stuff
//            self.updateAction(item: item, indexPath: IndexPath)
//            completionHandler(true)
//        })
//        let groupAction =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
//            //do stuff
//            self.groupAction(item: item, indexPath: indexPath)
//            completionHandler(true)
//        })
//        3/5 14:13
//        let deleteAction =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
//            self.deleteAction(item: item, indexPath: indexPath)
//            completionHandler(true)
//        })
//
//        let editAction =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
//            //do stuff
//            self.updateAction(item: item, indexPath: indexPath)
//            completionHandler(true)
//        })
//        let groupAction =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
//            //do stuff
//            self.groupAction(item: item, indexPath: indexPath)
//            completionHandler(true)
//        })
//        14:14
//        //xếp theo thứ tự ngược
//        let confrigation = UISwipeActionsConfiguration(actions: [deleteAction,editAction,groupAction])
//
//        return confrigation
//        14:14
//        private func groupAction(item: Cards,indexPath: IndexPath){
//
//        }
//    }
}
