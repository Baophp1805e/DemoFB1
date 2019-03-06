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
    var post : Post?{
        didSet {
            getComment()
        }
    }
    
    
    
    @IBOutlet weak var textComment: UITextField!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Comment"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getComment(){
        Database.database().reference().child("Comment").child((post?.idM)!).observe(.value) { (dataSnapshot) in
            if dataSnapshot.childrenCount > 0{
//                print(dataSnapshot)
                                            self.CMT.removeAll()
                for child in dataSnapshot.children{
                    let infor = Infor()
//                    let snap = child as! DataSnapshot
//                    let dict = snap.value as! [String:Any]
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String:Any]
                    let uid = dict["id"] as! String
                    let textComment = dict["textComment"] as! String
                    let time = dict["timeStamp"] as! NSNumber
                    let cmt = CommentModel(uid: uid, cmt: textComment, timeStamp: time)
                    infor.cmtInfor = cmt
                    Database.database().reference().child("Users").child(uid).observe(.value, with: { (data) in
                        if data.childrenCount > 0{

                            let dict = data.value as! [String: Any]
                            let profilePicLink = dict["profilePicLink"] as! String
//                            let username = dict["username"] as! String
                            let user = UserProfile(logoUser: profilePicLink )
                            infor.user = user
                            self.CMT.append(infor)
                            self.tableView.reloadData()
                        }
            })
                    self.tableView.reloadData()
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
        let refCmt = Database.database().reference().child("Comment").child((post?.idM)!)
        
        let timeStamp = NSNumber.init(value: Date().timeIntervalSince1970)
        
        let values : [String: Any] = ["id":Auth.auth().currentUser?.uid as Any,"textComment":textComment.text!,"timeStamp":timeStamp]
        refCmt.childByAutoId().setValue(values)
//        Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!).child("Cmt").updateChildValues(value)
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
        cell.avtUser.kf.setImage(with: URL(string: (data.user?.logoUserM)!))
        let exactDate = NSDate(timeIntervalSince1970: TimeInterval(truncating: (data.cmtInfor?.timeStamp)!))
        let dateFormatt = DateFormatter()
        dateFormatt.dateFormat = "hh:mm a"
        cell.lblTimer.text = dateFormatt.string(from: exactDate as Date)
        return cell
    }
}
