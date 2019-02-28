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
    var ref: DatabaseReference!
    
    @IBOutlet weak var lbluser: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
 
    @IBAction func btnPost(_ sender: Any) {
        AddData()
    }
    func AddData(){
        let key = ref.childByAutoId().key
        let AddData = ["id":key, "username":lbluser.text, "status":textView.text]
        ref.child(key!).setValue(AddData) { (error: Error?, ref: DatabaseReference) in
            if (error == nil) {
                self.dismiss(animated: true, completion: nil)
            } else {
                // show popup looi~
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("Post")
//        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
//        doneButton.clipsToBounds = true
        textView.delegate = self
        getDataName()
    }
    func getDataName()
    {
        Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!).observe(.value) { (snapshot) in
            print(snapshot)
            let name = (snapshot.value as! NSDictionary)["username"] as! String
            print(name)
            self.lbluser.text = name
        }
        
        //self.navigationController?.popViewController(animated: true)
    }
 

}
