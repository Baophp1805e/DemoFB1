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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Property
    var ref: DatabaseReference!
    var postlist = [Post]()
    var keyArray:[String] = []
   
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "NewFeed"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 234
        
        let nibName = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "cell")
        observePosts()
        
    }
    
    func observePosts() {

        ref = Database.database().reference()
        ref?.child("Post").observe(.value, with: {(snapshot) in

            for child in snapshot.children  {

                let snap = child as! DataSnapshot
                let dict = snap.value as! [String: Any]
                print(dict)
                let id = dict["id"] as! String
                let name = dict["status"] as! String
                let user = dict["username"] as! String
                let post = Post(id: id, user: user,  post: name)
                
                self.postlist.append(post)
            }
            self.tableView.reloadData()

            })

        
}
    
    //MARK: - Handle
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        cell.set(post: postlist[indexPath.row])
//        let data = postlist[indexPath.row]
//        cell.postLabel.text = data.postTextM
//        cell.userLabel.text = data.userM
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            observePosts()
//            let demo = postlist[indexPath.row]
//            let when = DispatchTime.now() + 1
//            DispatchQueue.main.asyncAfter(deadline: when, execute: {
//
//                self.ref?.child("Post").removeValue()
//                self.postlist.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//                self.keyArray = []
//            })
//
//        }
//
//    }
    
    func updateDemo(id: String, userUpdate: String, postUpdate: String)
    {
        let data = ["id" : id, "username" : userUpdate, "status" : postUpdate]
        ref.child("Post").child(id).setValue(data)

    }
//
    func deleteDemo(id: String)
    {
        ref.child("Post").child(id).removeValue()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let demo = postlist[indexPath.row]
        let alertController = UIAlertController(title:demo.userM, message: "Give new values to demo", preferredStyle:.alert)

        let updateAction = UIAlertAction(title: "Update", style: .default) { (_) in
            let id = demo.idM
            let userUpdate = alertController.textFields?[0].text
            let postUpdate = alertController.textFields?[1].text

            self.updateDemo(id: id!, userUpdate: userUpdate!, postUpdate: postUpdate!)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (_) in
            self.deleteDemo(id: demo.idM!)
            self.postlist.remove(at: indexPath.row)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addTextField { (textField) in
            textField.text = demo.userM
        }
        alertController.addTextField { (textField) in
            textField.text = demo.postTextM
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }
}
