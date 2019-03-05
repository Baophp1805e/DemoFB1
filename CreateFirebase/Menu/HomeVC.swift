//
//  HomeVC.swift
//  CreateFirebase
//
//  Created by Ominex on 2/11/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    
    @IBOutlet weak var lblDisplayEmail: UILabel!
    
    
    @IBAction func btnHome(_ sender: Any) {
        print("btn")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewFeedVC") as? NewFeedVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       guard let email = Auth.auth().currentUser?.email
      
        else
        {
            return
        }
        lblDisplayEmail.text = "Hello : \(email)"
    }
    


    // MARK: - Navigation
    @IBAction func btnLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "homeSegue", sender: sender)
        } catch  {
            print(error)
        }
        
    }
 

}
