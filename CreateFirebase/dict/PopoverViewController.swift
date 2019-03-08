//
//  PopoverViewController.swift
//  CreateFirebase
//
//  Created by Bao on 3/7/19.
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit
import Firebase

class PopoverViewController: UIViewController {
     // MARK: - Property
    var idPost: String?
    var ref: DatabaseReference!
    var delegateDelete: DeleteDelegate?
    var editDelegate: EditDelegateProtocol?
    var indexpath:IndexPath!
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Handle Setting
    @IBAction func btnEdit(_ sender: Any) {
        editDelegate?.didClickEdit(idPost: idPost!,indexPath: self.indexpath)
//        self.removeAnimate()
    }
    
    
    @IBAction func btnDelete(_ sender: Any) {
        print("Delete Tapped")
        delegateDelete?.didClickDelete(idPost: idPost!)
        self.removeAnimate()
//        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancle(_ sender: Any) {
         self.removeAnimate()
    }
   

    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}

